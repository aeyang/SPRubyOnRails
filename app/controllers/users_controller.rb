class UsersController < ApplicationController

  before_filter :authenticate, :only => [:show]

  def show
  	@user = User.find(params[:id])
  	@title = @user.username
    @lastapi = LastApi.new
  end

  def new
  	@title = "Sign Up"
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
  	  sign_in @user
      flash[:success] = "Welcome to the Music Explorer!"
  	  redirect_to @user
  	else
  	  @title = "Sign Up"
  	  render 'new'
  	end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

end
