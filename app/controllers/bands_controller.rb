class BandsController < ApplicationController
  def create
  	@title = "Create"
  	respond_to do |format|
  	  format.html {redirect_to search_path}
  	  format.js
  	end
  end

  def destroy
  end

end
