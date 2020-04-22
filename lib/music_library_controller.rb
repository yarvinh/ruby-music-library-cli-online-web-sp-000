class MusicLibraryController
  attr_accessor :path, :songs
  def initialize(path = './db/mp3s')
    @path = path
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
  loop do
      puts "What would you like to do?"
      user_input = gets
    if user_input == 'exit'
      break
    elsif user_input == 'list songs'
      list_songs
    elsif user_input == 'list artists'
      list_artists
    elsif user_input == 'list genres'
      list_genres
    elsif user_input == 'list artist'
      list_songs_by_artist
    elsif user_input == 'list genre'
      list_songs_by_genre
    elsif user_input == 'play song'
      play_song
    end
  end

  end
   def list_songs
     songs =  Song.all.map{|s| s.name}
     songs.sort.each_with_index{|s,index|
        Song.all.each{|song|
          if song.name == s
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
          end
        }
     }
   end

   def list_artists
     artists = []
     Artist.all.each{|a| artists << a.name}
     artists.sort.each_with_index{|a,index| puts "#{index + 1}. #{a}"
     }
   end

   def list_genres
     genres = []
     Genre.all.each{|g| genres << g.name}
     genres.sort.each_with_index{|g,index| puts "#{index + 1}. #{g}"
     }
   end

   def list_songs_by_artist
     puts "Please enter the name of an artist:"
     user_input = gets
     Artist.all.each{|a|
      if  user_input == "#{a.name}"
         song = a.songs.map{|s| "#{s.name} - #{s.genre.name}"}
         song.sort.each_with_index{|song,index|  puts "#{index + 1}. #{song}"
        }
      end
      }
   end

   def list_songs_by_genre
     puts "Please enter the name of a genre:"
     user_input = gets
     Genre.all.each{|g|
      if  user_input == "#{g.name}"
        #  counter = 1
         songs = g.songs.map{|s|"#{s.name} - #{s.artist.name}"}
         songs.sort.each_with_index{|s,index| song = s.split(" - ").reverse.join(" - ")
         puts "#{index + 1}. #{song}"
        #  counter += 1
       }
      end
      }
   end

   def play_song
    #  songs = []
    #  counter = 1
    #  @song_by_alphabetical_oder = []
    #  Song.all.each{|s| songs << s.name}
    #  songs.sort.each{|s|
    #    song_by_alphabetical_oder = ""
    #     Song.all.map {|song|
    #       if song.name == s
    #           song_by_alphabetical_oder = "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    #           @song_by_alphabetical_oder << song_by_alphabetical_oder
    #       end
    #     }
    #     counter += 1
    #  }
    #   puts "Which song number would you like to play?"
    #  user_input = gets
    #  counter = 0
    #  @song_by_alphabetical_oder.map{|s|
    #    counter += 1
    #    counter.to_s
    #    if s[0] == user_input
    #      list =  s.tr("#{counter}.","")
    #      list_song = list.split(" - ")
    #      list_song.pop
    #      song = list_song
    #                  puts "Playing #{song[1]} by#{song[0]}"
    #     end
    # }







    puts "Which song number would you like to play?"
    user_input = gets
    songs = Song.all.map{|s| s.name}
    songs.sort.each_with_index{|s,index|
       Song.all.each{|song|
         if song.name == s
            song_by_alphabetical_oder = "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            if song_by_alphabetical_oder[0] == user_input
              list =  song_by_alphabetical_oder.tr("#{song_by_alphabetical_oder[0]}.","")
              list_song = list.split(" - ")
              list_song.pop
              puts "Playing #{list_song[1]} by#{list_song[0]}"
             end
         end
       }
    }
   end
end
