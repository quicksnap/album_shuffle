require 'album_shuffle/version'
require 'find'

class AlbumShuffle

  def initialize( options = {} )
    options( options )
  end

  # Returns options after overriding existing or setting defaults
  def options( options = {} )

    if @options
      # If called when options exist, override pass options
      @options = @options.merge( options )
    else
      # Default options
      @options = {
          base_path: Dir.pwd,
          folder_limit: 0,
        }.merge( options )
    end

    @options
  end

  def collect
    song_dirs = []

    # Finds all directories that contain mp3 files
    Find.find( @options[:base_path] ) do | path |
      yield(path) if block_given?
      # Find.prune if @options[:folder_limit] && song_dirs.length >= options[:folder_limit]
      if ( File.basename( path ) =~ /.mp3$/ ) != nil
        dirname = File.dirname( path )
        song_dirs << dirname unless song_dirs.include?( dirname )
      end
    end

    song_dirs
  end

  def shuffle
    all_dirs = collect {|path| yield(path) if block_given? }
    limit = @options[:folder_limit]
    random_dirs = []

    if( limit > 0 )
      random_dirs = all_dirs.sample(limit)
    end

    random_dirs
  end

end
