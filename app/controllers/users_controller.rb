class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@title = "Sign Up"
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
  	  #stuff
  	else
  	  render 'new'
  	end
  end

end
