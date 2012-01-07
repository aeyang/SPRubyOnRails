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
  	#Amazon_product gem setup
  	req = AmazonProduct['us']
  	req.configure do |c|
  	  c.key = 'AKIAJKWWS7XBCREYXFBA'
  	  c.secret = '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'
  	  c.tag = 'musiexplsenip-20'
    end
  	
  	req << {
  		operation => 'ItemSearch',
  		:search_index => 'All',
  		:Keywords => 'Book',
  		:response_group => ['ItemAttributes', 'Images'],
  		:Version => '2011-08-01'
  	}

  	@resp = req.get
  	#@resp = req.search('George Orwell')
  end

end
