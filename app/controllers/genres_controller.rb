class GenresController < ApplicationController
<<<<<<< HEAD
    
    def index
        @genres = Genre.all
    end
    
    def show
        set_genre
    end
    
    private
    
    def set_genre
        @genre = Genre.find(params[:id])
    end
=======
	def show
		@genre = Genre.find(params[:id])
		render json: @genre
	end

	def index
		@genres = Genre.all
		render json: @genres
	end
>>>>>>> jQuery_front_end
end
