class Band < ActiveRecord::Base

  #Declaring Band relationship to User
  has_and_belongs_to_many :users

  #name is changeable from the outside world
  attr_accessible :name

end
# == Schema Information
#
# Table name: bands
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

