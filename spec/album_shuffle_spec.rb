require 'spec_helper'
require 'album_shuffle'
require 'fakefs/spec_helpers'
require 'fileutils'

describe AlbumShuffle do

  # This helper allows FakeFS to persist through all tests
  include FakeFS::SpecHelpers::All

  # Generate a fake file structure
  before :all do
    (1..4).each do |artist_n|
      (1..2).each do |album_n|
        (1..2).each do |disc_n|
          path = "My Music/Some Artist #{artist_n}/2002 - Some Album #{album_n}/Disc #{disc_n}"
          FileUtils.mkdir_p path
          (1..7).each do |song_n|
            FileUtils.touch path + "/#{song_n} - Song.mp3"
          end
        end
      end
    end
  end

  before :each do
    @album_shuffle = AlbumShuffle.new
  end

  describe  '#options' do
    it "sets options" do
      options = @album_shuffle.options(:some_option => 'x')
      options[:some_option].should eq 'x'
    end
  end

  describe '#collect' do
    it "returns some directories" do
      folders = @album_shuffle.collect
      folders.should be_an Array
      folders.grep(/Some Album/).length.should be > 2
    end

    it "only collects folders with music" do
      folders = @album_shuffle.collect
      folders.sample(2).each do |folder|
        Dir[ File.join( folder, '*.mp3' ) ].length.should be > 0
      end
    end
  end

  describe '#shuffle' do
    it "outputs specifc number of folders" do
      @album_shuffle.options(:folder_limit => 5)
      folders = @album_shuffle.shuffle
      folders.length.should eq 5

      @album_shuffle.options(:folder_limit => 10)
      folders = @album_shuffle.shuffle
      folders.length.should eq 10
    end
  end
end