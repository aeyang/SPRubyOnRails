class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@title = @user.username
  end

  def new
  	@title = "Sign Up"
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
      flash[:success] = "Welcome to the Music Explorer!"
  	  redirect_to @user
  	else
  	  render 'new'
  	end
  end

end
