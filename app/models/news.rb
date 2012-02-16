require 'rbing'

class News 
  attr_reader :rsp

  def initialize(search_term)
    @search_term = search_term
    bing = RBing.new("495E3EBA51EC8A08B80725625EBEF9F55D1152C3")
    @rsp = bing.news(search_term, :category => "rt_Entertainment") 
  end

  def getStory()
    @rsp.each_with_index do |story, index|
      if @rsp.news.results[index].title =~ /#{@search_term.gsub(" ", "\\W*")}/i
        return @rsp.news.results[index]
      else
        return nil
      end
    end
  end
end


