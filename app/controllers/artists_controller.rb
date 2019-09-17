require 'pry'

class ArtistsController < ApplicationController
    
    def show
        set_artist
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @artist }
        end
    end
    
    def index
        @artist = Artist.new
        @artists = Artist.order(:name)
        respond_to do |format|
            format.html { render :index }
            format.json { render json: @artists }
            #format.json { render :json => {:artists => @artists, :current_user => current_user }}
        end
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
            flash[:notice] = 'Artist was successfully created.'
            format.json { render json: { status: :true } }
            format.html { render :show }
          else
            format.html { render :new }
          end
        end
    end
    
    def update
        set_artist
        respond_to do |format|
          if @artist.update(artist_params)
            flash[:notice] = 'Artist was successfully updated.'
            format.html { redirect_to @artist }
          else
            format.html { render :edit }
          end
        end
    end
    
    def destroy
        set_artist
        @artist.destroy
        respond_to do |format|
            flash[:notice] = 'Artist was successfully destroyed.'
            format.html { redirect_to artists_url }
        end
    end
    
    private
    
    def set_artist
        @artist = Artist.find(params[:id])
    end
    
    def artist_params
        params.require(:artist).permit(:name, :avatar, :bio)
    end

end
