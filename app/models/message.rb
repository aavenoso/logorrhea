class Message < ActiveRecord::Base

  PRIORITIES = [:urgent, :important, :casual, :fun]

  belongs_to :user
  belongs_to :parent
  has_many :children, :class_name  => "Message", :foreign_key => :parent_id, :dependent => :destroy
  
  def descendants
    # return (self.children + self.children.collect{|x| x.descendants }).flatten.compact
    (dids=descendant_ids).blank? ? [] : self.class.find(dids)
  end
  alias :thread :descendants
  
  def descendant_ids
    conn = ActiveRecord::Base.connection
    generation_array = conn.execute("select id from messages where parent_id=#{self.id}").to_enum.collect(){|x| x}.flatten
    desc_ids = []
    while(!generation_array.empty?)
      desc_ids += generation_array
      generation_array = conn.execute("select id from messages where parent_id in (#{generation_array.join(',')})").to_enum.collect(){|x| x}.flatten
    end#while !generation_array.empty?
    return desc_ids.collect(){|some_string_id| some_string_id.to_i }
  end#descendant_ids
  
  named_scope :urgent,
              :conditions => "priority = #{PRIORITIES.index(:urgent)}",
              :order => "messages.created_at DESC"
  named_scope :recent,
              lambda { |limit = 15, *|
                {:limit => limit, :order => "messages.created_at DESC"}
              }
  named_scope :mentioning,
              lambda { |txt = '', *|
                {:conditions => "body like '%#{txt}%'"}
              }
  
  validates_presence_of :body
  validates_presence_of :user_id
  validates_length_of :body, :within => 2..140
  
  def priority
    PRIORITIES[self[:priority]]
  end
  
  def priority=(sym)
    self[:priority] = PRIORITIES.index(sym)
  end
  
  def body_for_display
    body.gsub %r{(http://\S*)} do |url|
      %Q{<a href="#{url}">#{url}</a>}
    end
  end
end
