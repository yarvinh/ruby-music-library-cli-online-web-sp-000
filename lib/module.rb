

module Concerns
  module Findable
    def find_by_name(name)
      song = ""
      self.all.each{|item|
       if item.name == name
         song = item
       end
     }
     @song = song
    end

     def find_or_create_by_name(name)
       song = self.find_by_name(name)
        if song == ""
            self.create(name)
        else
           song
        end
     end
   end
end
