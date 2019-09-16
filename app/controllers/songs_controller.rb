require 'pry'

class SongsController < ApplicationController
    
    def show
        set_song
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @song }
        end
    end
    
    def new
      set_album
      @song = @album.songs.build
    end
    
    def edit
      #Checks to confirm there is an album id in params
      if params[:album_id]
        set_album
        if @album.nil?
          redirect_to albums_path(@album), alert: "Album not found."
        else
          @song = @album.songs.find_by(id: params[:id])
          redirect_to album_path(@album), alert: "Song not found." if @song.nil?
        end
        #If we make it this far, the song and album data are valid, so set the song and render the edit page
        set_song
      end
    end
    
    def create
        set_album
        @song = @album.songs.build(song_params)
        respond_to do |format|
          if @song.save
            flash[:notice] = 'Song was successfully created.'
            format.html { redirect_to album_path(@album) }
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
      set_song
      set_album
        @song.destroy
        respond_to do |format|
          flash[:notice] = 'Song was successfully destroyed.'
          format.html { redirect_to  @album }
        end
    end
    
    def favorite
      set_song
      type = params[:type]
      
      if type == "favorite"
        current_user.favorite_songs << @song
        flash[:notice] = "You favorited #{@song.name}"
        redirect_to album_song_path(@song)
  
      elsif type == "unfavorite"
        current_user.favorite_songs.delete(@song)
        flash[:notice] = "Unfavorited #{@song.name}"
        redirect_to album_song_path(@song)
  
      else
        # Type missing, nothing happens
        flash[:notice] = "Nothing happened."
        redirect_to :back
      end
    end

    def index
      set_album
      render json: @album.songs
    end

    def last
      render json: Song.last
    end
    
    private
    
    def set_song
        @song = Song.find(params[:id])
    end

    def set_album
      @album = Album.find_by(id: params[:album_id])
    end
    
    def song_params
        params.require(:song).permit(:name, :length, :album_id, :genre_name)
    end
end
