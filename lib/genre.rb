class Genre
    extend Concerns::Findable
    attr_accessor :name#, :artists, :songs
    @@all = []
    def initialize(name)
        @name = name
        save
        @songs = []
    end

   def save
    @@all << self
   end
    def self.all
        @@all
    end
    def self.destroy_all
        self.all.clear
    end
    def self.create(song)
        Genre.new(song)
  end

  def songs
    song = Song.all.select {|song| song.genre == self }
    song.each{ |song| @songs << song}
    if @songs != []
      @songs.uniq
    else @songs
    end
  end

  def artists
    Artist.all.select{|artist| artist}
  end
end
