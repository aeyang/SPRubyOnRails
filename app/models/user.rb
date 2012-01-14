class User < ActiveRecord::Base
	attr_accessible :username
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  username           :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  longitude          :float
#  latitude           :float
#

