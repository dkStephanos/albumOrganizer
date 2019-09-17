class AccessRequestsController < ApplicationController
  protect_from_forgery with: :exception
    
  	def new
  		if AccessRequest.where(requester_id: params[:currentUserId], requested_id: params[:userId]).empty? == false
  			flash[:notice] = 'Already Requested.'
  			redirect_to "/home"
  		else
      		access_request = AccessRequest.create(requester_id: params[:currentUserId], requested_id: params[:userId], isApproved: false)
	      	if access_request.save
	        	flash[:notice] = 'Request was made successfully.'
	        	redirect_to "/home"
	      	else
	        	flash[:notice] = @access_request.errors
	        	redirect_to "/home"
	      	end
	    end
  	end

  	def approve
  		access_request = AccessRequest.find(params[:id])
  		access_request.isApproved = true
  		if access_request.save
  			flash[:notice] = 'Request approved.'
	        redirect_to "/home"
	    else
			flash[:notice] = @access_request.errors
	        redirect_to "/home"
	   	end
  	end
end
