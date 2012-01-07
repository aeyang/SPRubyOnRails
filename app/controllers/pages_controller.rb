class PagesController < ApplicationController
  def home
    @title = "Home";
  end

  def about
    @title = "About";
  end

  def lastFM
  	@title = "LastFM"
  end

  def Amazon
  	@title = "Amazon"
  end

end
