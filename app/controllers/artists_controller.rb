class ArtistsController < ApplicationController
    
    def show
        @artist = Artist.find(params[:artist_id])
    end
end
