require 'pry'

class ArtistsController < ApplicationController
    
    def show
        set_artist
    end
    
    def index
        @artists = Artist.all
    end
    
    def new
        @artist = Artist.new
    end
    
    def edit
        set_artist
        @artist.albums.build
    end
    
    def create
        @artist = Artist.new(artist_params)
        @artist.user = current_user
        respond_to do |format|
          if @artist.save
            format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
          else
            format.html { render :new }
          end
        end
    end
    
    def update
        set_artist
        respond_to do |format|
          if @artist.update(artist_params)
            format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
          else
            format.html { render :edit }
          end
        end
    end
    
    def destroy
        set_artist
        @artist.destroy
        respond_to do |format|
          format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
        end
    end
    
    private
    
    def set_artist
        @artist = Artist.find(params[:id])
    end
    
    def artist_params
        params.require(:artist).permit(:name, :bio)
    end

end
