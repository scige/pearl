class Group < ActiveRecord::Base
  has_many :users

  attr_accessible :name, :school, :university
end
