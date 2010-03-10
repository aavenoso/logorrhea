class User < ActiveRecord::Base
  belongs_to :team
  has_many :messages

  validates_presence_of :username, :first_name, :last_name, :email, :password
  validates_format_of :email, with:  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :password, minimum: 7
 
end
