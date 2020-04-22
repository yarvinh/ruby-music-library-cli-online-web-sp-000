class Song
     attr_accessor :name
     attr_reader  :artist, :genre#, :create_from_filename, :find_or_create_by_name
     @@all = []

    def initialize(name, artists = "none", genres = "none" )
        @name = name
        save
        if artists != "none"
           self.artist=(artists)
        end
        if genres != "none"
          self.genre=(genres)
        end
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

    def self.create(create_song)
       Song.new(create_song)
    end

    def artist=(artist)
      @artist = artist
      artist.add_song(self)
      end

      def genre=(genre)
         @genre = genre
   end

   def self.find_by_name(name)
        song = ""
        @@all.each{|s|
         if s.name == name# || s.artist == name || s.genre == name
           song = s
         end
       }
       @song = song
   end

       def self.find_or_create_by_name(name)
         song = self.find_by_name(name)
          if song == ""
              self.create(name)
          else
             song
          end
       end

   def self.new_from_filename(file)
         fix_string_from_file = file.split(/\.|,/)
         fix_string_from_file.pop
         step_2 = fix_string_from_file.join
         step_3 = step_2.split(" - ")
         step_3.select{|e| e != ""}
         artist =  Artist.find_or_create_by_name(c[0])
         genre = Genre.find_or_create_by_name(c[2])
         Song.new(c[1],artist,genre)
   end

   def self.create_from_filename(file)
    self.new_from_filename(file)
   end
end
