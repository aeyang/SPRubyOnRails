class PagesController < ApplicationController

  def home
    @title = "Home";
    @resp = nil
    if signed_in?
      @resp = Array.new 
      current_user.bands.each do |band|
        temp = News.new(band.name).getStory
        @resp << temp unless temp.nil?
      end 
    end
  end

  def about
    @title = "About";
  end

  def lastFM
  	@title = "LastFM"

    respond_to do |format|
      format.html
      format.js
    end

  end

  def amazon
    @title = "Amazon"
    @search = params[:amazon_search_form]

  	#Amazon_product gem setup
  	req = AmazonProduct['us']
  	req.configure do |c|
  	  c.key = 'AKIAITDQ43M6CV7CVTMA'
  	  c.secret = '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'
  	  c.tag = 'musiexplsenip-20'
    end

  	req << {
  		:operation => 'ItemSearch',
  		:search_index => 'Music',
  		:Keywords => 'album',
  		:response_group => ['ItemAttributes', 'Images'],
  		:Artist => @search
  	}

  	@resp = req.get
  	
  end

  def search
    @title = "Search"
    @band = Band.new

    respond_to do |format|
      format.html 
      format.js
    end

  end

end
