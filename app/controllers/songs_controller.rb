require 'pry'

class SongsController < ApplicationController
    
    def show
        @song = Song.find(params[:id])
    end
    
    def new
        @song = Song.new
    end
    
    def edit
      if params[:album_id]
        album = Album.find_by(id: params[:album_id])
        if album.nil?
          redirect_to albums_path, alert: "Album not found."
        else
          @song = album.songs.find_by(id: params[:id])
          redirect_to album_songs_path(album), alert: "Song not found." if @song.nil?
        end
      else
        set_song
      end
    end
    
    def create
        @song = Song.new(song_params)
        respond_to do |format|
          if @song.save
            format.html { redirect_to @song, notice: 'Song was successfully created.' }
          else
            format.html { render :new }
          end
        end
    end
    
    def update
        set_song
        respond_to do |format|
          if @song.update(song_params)
            format.html { redirect_to @song, notice: 'Song was successfully updated.' }
          else
            format.html { render :edit }
          end
        end
    end
    
    def destroy
        @song.destroy
        respond_to do |format|
          format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
        end
    end
    
    def favorite
      set_song
      type = params[:type]
      
      if type == "favorite"
        current_user.favorite_songs << @song
        redirect_to @song, notice: 'You favorited #{@song.name}'
  
      elsif type == "unfavorite"
        current_user.favorite_songs.delete(@song)
        redirect_to @song, notice: 'Unfavorited #{@song.name}'
  
      else
        # Type missing, nothing happens
        redirect_to :back, notice: 'Nothing happened.'
      end
    end
    
    private
    
    def set_song
        @song = Song.find(params[:id])
    end
    
    def song_params
        params.require(:song).permit(:name, :length, :album_id, :genre_name)
    end
end
