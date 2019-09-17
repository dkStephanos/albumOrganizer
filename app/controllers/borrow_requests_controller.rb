class BorrowRequestsController < ApplicationController
  protect_from_forgery with: :exception
    
  	def new
  		artist = Artist.find(params[:artistId])
  		user = User.find(artist.user_id)
  		if BorrowRequest.where(user_id: current_user.id, artist_id: params[:artistId], requested_user_id: user.id).empty? == false
  			flash[:notice] = 'Already Requested.'
  			redirect_to "/home"
  		else
      		borrow_request = BorrowRequest.create(user_id: current_user.id, artist_id: params[:artistId], requested_user_id: user.id, isAccepted: false)
	      	if borrow_request.save
	        	flash[:notice] = 'Request was made successfully.'
	        	redirect_to "/home"
	      	else
	        	flash[:notice] = borrow_request.errors
	        	redirect_to "/home"
	      	end
	    end
  	end

  	def accept
  		borrow_request = BorrowRequest.find(params[:id])
  		borrow_request.isAccepted = true
  		artist = Artist.find(borrow_request.artist_id)
  		artist.loaned_user = User.find(borrow_request.user_id)
  		artist.isLoaned = true
  		artist.save
  		if borrow_request.save
  			flash[:notice] = 'Request approved.'
	        redirect_to "/home"
	    else
			flash[:notice] = borrow_request.errors
	        redirect_to "/home"
	   	end
  	end
end
