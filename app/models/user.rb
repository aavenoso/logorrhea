class User < ActiveRecord::Base
  belongs_to :team
  has_many :messages

  validates_presence_of :email
  validates_format_of :email, with:  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :password, minimum: 7, message: 'Password must be 6 or more characters'
  validates_presence_of :username
  validates_presence_of :first_name
  validates_presence_of :last_name

end
