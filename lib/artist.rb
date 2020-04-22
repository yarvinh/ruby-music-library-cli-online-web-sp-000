class Artist
    extend Concerns::Findable
    attr_accessor :name#, :songs, :genres
    @@all = []
    def initialize(name)
        @name = name
         @songs = []
        save
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
    def self.create(artist)
        Artist.new(artist)
    end
    def add_song(song)
       @@all.each {|songs|
          if song.artist != self
             song.artist = self
          end
        }

   end
   def songs
    song = Song.all.select {|song| song.artist == self }
    song.each{|s| @songs << s}
    if @songs != []
      @songs.uniq
     else @songs
    end
   end

   def genres
     song = Song.all.map{|s|
       s.genre
     }
     song.uniq
   end

end
