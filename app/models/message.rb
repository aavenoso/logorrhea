class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent
  has_many :children, :class_name  => :message, :foreign_key => :parent_id, :dependent => :destroy
  
  PRIORITIES = [:urgent, :important, :casual, :fun]
  
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
