class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper #This is to make available the functions in SessionsHelper to the controllers. 
end
