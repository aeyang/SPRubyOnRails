class SessionsController < ApplicationController
  def new
  	@title = 'Sign in'
  end

  def create
  	user = User.authenticate(params[:session][:username], params[:session][:password])

  	if user.nil?
  	  #For Users, we took advantage of Active Record error messages. Since Session is not an Active Record object, we cant do that;
  	  #therefore, we put an error message in the flash
  	  flash.now[:error] = "Invalid username/password combination"
  	  #We set the title here b/c the next line will render the page; it will not send a request to the 'new' action. 
  	  @title = 'Sign in'
  	  render 'new'
  	else
  	  #Sign the user in and redirect to user's show page
  	  sign_in user
  	  redirect_to user
  	end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end

end
