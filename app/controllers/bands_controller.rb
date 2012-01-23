class BandsController < ApplicationController
  def create
  	@name = params[:band][:artist]
  end

  def destroy
  end

end
