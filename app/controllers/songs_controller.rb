class SongsController < ApplicationController
    
    def show
        @song = Song.find(params[:id])
    end
    
    def new
        @song = Song.new
    end
    
    def edit
        set_song
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
    
    private
    
    def set_song
        @song = Song.find(params[:id])
    end
    
    def song_params
        params.require(:song).permit(:name, :length, :album_id)
    end
end
