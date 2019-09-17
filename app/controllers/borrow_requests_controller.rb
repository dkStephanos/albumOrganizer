class BorrowRequestsController < ApplicationController
  protect_from_forgery with: :exception
    
  	def new
  		if BorrowRequest.where(user_id: params[:currentUserId], artist_id: params[:artistId]).empty? == false
  			flash[:notice] = 'Already Requested.'
  			redirect_to "/home"
  		else
      		borrow_request = BorrowRequest.create(user_id: params[:currentUserId], artist_id: params[:userId], isAccepted: false)
	      	if borrow_request.save
	        	flash[:notice] = 'Request was made successfully.'
	        	redirect_to "/home"
	      	else
	        	flash[:notice] = @borrow_request.errors
	        	redirect_to "/home"
	      	end
	    end
  	end

  	def approve
  		borrow_request = BorrowRequest.find(params[:id])
  		borrow_request.isAccepted = true
  		if borrow_request.save
  			flash[:notice] = 'Request approved.'
	        redirect_to "/home"
	    else
			flash[:notice] = @borrow_request.errors
	        redirect_to "/home"
	   	end
  	end
end
