class AlbumsController < ApplicationController
    
    def show
        @album = Album.find(params[:id])
    end
    
    def index
        @albums = Album.all
    end
    
    def new
        @album = Album.new
    end
    
    def edit
        if params[:artist_id]
            artist = Artist.find_by(id: params[:artist_id])
            if artist.nil?
              redirect_to artists_path, alert: "Artist not found."
            else
              @album = artist.albums.find_by(id: params[:id])
              redirect_to artist_albums_path(artist), alert: "Album not found." if @album.nil?
            end
        else
           set_album
        end
    end
    
    def create
        @album = Album.new(album_params)
        respond_to do |format|
          if @album.save
            format.html { redirect_to @album, notice: 'Album was successfully created.' }
          else
            format.html { render :new }
          end
        end
    end
    
    def update
        set_album
        respond_to do |format|
          if @album.update(album_params)
            format.html { redirect_to @album, notice: 'Album was successfully updated.' }
          else
            format.html { render :edit }
          end
        end
    end
    
    def destroy
        @album.destroy
        respond_to do |format|
          format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
        end
    end
    
    private
    
    def set_album
        @album = Album.find(params[:id])
    end
    
    def album_params
        params.require(:album).permit(:name, :release_date, :artist_id)
    end
end
