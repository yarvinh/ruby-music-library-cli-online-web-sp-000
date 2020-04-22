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
     songs.sort.each{|s|
        Song.all.each_with_index {|song,index|
          if song.name == s
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
          end
        }
     }
   end

   def list_artists
     artists = []
    #  counter = 1
     Artist.all.each_with_index{|a,index| artists << a.name}
     artists.sort.each{|a| puts "#{index + 1}. #{a}"
      #  counter += 1
     }
   end

   def list_genres
     genres = []
     counter = 1
     Genre.all.each{|g| genres << g.name}
     genres.sort.each{|g| puts "#{counter}. #{g}"
       counter += 1
     }
   end

   def list_songs_by_artist
     puts "Please enter the name of an artist:"
     user_input = gets
     Artist.all.each{|a|
      if  user_input == "#{a.name}"
         counter = 1
         song = a.songs.map{|s| "#{s.name} - #{s.genre.name}"}
            song.sort.each{|song|  puts "#{counter}. #{song}"
          counter += 1
        }
      end
      }
   end

   def list_songs_by_genre
     puts "Please enter the name of a genre:"
     user_input = gets
     Genre.all.each{|g|
      if  user_input == "#{g.name}"
         counter = 1
         songs = g.songs.map{|s|"#{s.name} - #{s.artist.name}"}
         songs.sort.each{|s| song = s.split(" - ").reverse.join(" - ")
         puts "#{counter}. #{song}"
         counter += 1
       }
      end
      }
   end

   def play_song
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
