class MusicImporter
  attr_accessor :path
  def initialize(path)
     @path = path
     @all = []
   end

   def files
     Dir.foreach(@path) do |fname|
      @all << fname
     end
     @all.delete(".")
     @all.delete("..")
     @all
   end

   def import
     files.each {|f| Song.create_from_filename(f)}
   end
end
