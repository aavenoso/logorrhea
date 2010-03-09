class Message < ActiveRecord::Base

  PRIORITIES = [:urgent, :important, :casual, :fun]

  belongs_to :user
  belongs_to :parent
  has_many :children, :class_name  => :message, :foreign_key => :parent_id, :dependent => :destroy
  
  named_scope :urgent,
              :conditions => "priority = #{PRIORITIES.index(:urgent)}",
              :order => "created_at DESC"
  named_scope :recent,
              lambda { |limit = 15, *|
                {:limit => limit, :order => "created_at DESC"}
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
end
