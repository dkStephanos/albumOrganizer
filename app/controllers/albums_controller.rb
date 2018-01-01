class AlbumsController < ApplicationController
    
    def show
        @album = Album.find(params[:id])
    end
    
    def index
        @albums = Album.all
    end
end
