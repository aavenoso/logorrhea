class Team < ActiveRecord::Base
  validates_presence_of :name
  
  has_many :users
  has_many :messages, :through => :users do
    def most_recent(count=5)
      all(:order => "messages.created_at desc", :limit => count)
    end
  end

end
