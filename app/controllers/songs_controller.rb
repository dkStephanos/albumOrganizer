require 'pry'

class SongsController < ApplicationController
    
    def show
        @song = Song.find(params[:id])
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @song }
        end
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
            flash[:notice] = 'Song was successfully created.'
            format.html { redirect_to @song }
          else
            format.html { render :new }
          end
        end
    end
    
    def update
        set_song
        respond_to do |format|
          if @song.update(song_params)
            flash[:notice] = 'Song was successfully updated.'
            format.html { redirect_to @song }
          else
            format.html { render :edit }
          end
        end
    end
    
    def destroy
        @song.destroy
        respond_to do |format|
          flash[:notice] = 'Song was successfully destroyed.'
          format.html { redirect_to songs_url }
        end
    end
    
    def favorite
      set_song
      type = params[:type]
      
      if type == "favorite"
        current_user.favorite_songs << @song
        flash[:notice] = 'You favorited #{@song.name}'
        redirect_to @song
  
      elsif type == "unfavorite"
        current_user.favorite_songs.delete(@song)
        flash[:notice] = 'Unfavorited #{@song.name}'
        redirect_to @song
  
      else
        # Type missing, nothing happens
        flash[:notice] = 'Nothing happened.'
        redirect_to :back
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
