class LastApi

  def initialize
  end

  def findArtistInfo(name)
    artist = Rockstar::Artist.new(name, :autocorrect => 1, :include_info => true)

    return artist unless artist.nil?
  end

end
