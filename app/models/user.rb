class User < ActiveRecord::Base

	#creates instance variable password
	attr_accessor :password
	#Make these accessible to clients because they have to fill in these fields with (form_for)
	attr_accessible :username, :password, :password_confirmation, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size,
	                :avatar_updated_at

	#Paperclip to attach images
	has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100"}

	validates(:username, :presence => true,
	                 :length   => { :maximum => 50}, 
	                 :uniqueness => true)

    validates(:password, :presence => true,    
                         :confirmation => true,   #automatically creates an instance variable called password_confirmation
                         						  #and checks if it matches the password
                         :length => { :within => 6..40})

    
    #public method for outside use
    def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
    end

    #This is a class method. You call it on the entire User class and not a User object. The method has_password?
    #is a method that can be called on a specific User object to see if the object has the specified password. This 
    #method is interested in all the users in the database. Thus, it is called on the entire User class.
    def User.authenticate(username, submitted_password)
      user = find_by_username(username) # Dont have to do: User.find_by_username()
      return nil if user.nil?
      return user if user.has_password?(submitted_password)
      #If we reach the end of the method without returning explicitly, it will return with nil
    end

    def User.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      return nil if user.nil?
      return user if user.salt == cookie_salt
    end

    #callback to be executed before save to db
    before_save :encrypt_password

    #private methods
    private
    
      def encrypt_password
      	self.salt = make_salt if new_record?
        self.encrypted_password = encrypt(password)
      end
      
      def encrypt(string)
      	secure_hash("#{salt}--#{string}")
      end	               
      
      def make_salt
      	secure_hash("#{Time.now.utc}--#{password}")
      end
      
      def secure_hash(string)
      	Digest::SHA2.hexdigest(string)
      end  
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

