class AlbumsController < ApplicationController
    
    def show
        @album = Album.find(params[:id])
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @album }
        end
    end
    
    def index
        @album = Album.new
        @albums = Album.order(:name)
        respond_to do |format|
            format.html { render :index }
            format.json { render json: @albums }
        end
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
            flash[:notice] = 'Album was successfully created.'
            format.json { render json: { status: :true } }
            format.html { render :show }
          else
            format.html { render :new }
          end
        end
    end
    
    def update
        set_album
        respond_to do |format|
          if @album.update(album_params)
            flash[:notice] = 'Album was successfully updated.'
            format.html { redirect_to @album }
          else
            format.html { render :edit }
          end
        end
    end
    
    def destroy
        set_album
        @album.destroy
        respond_to do |format|
            flash[:notice] = 'Album was successfully destroyed.'
            format.html { redirect_to albums_url }
        end
    end
    
    private
    
    def set_album
        @album = Album.find(params[:id])
    end
    
    def album_params
        params.require(:album).permit(:name, :release_date, :album_cover, :artist_id)
    end
end
