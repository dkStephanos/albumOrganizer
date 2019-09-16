class AccessRequestsController < ApplicationController
  protect_from_forgery with: :exception
    
  	def new
      access_request = AccessRequest.create(requester_id: params[:currentUserId], requested_id: params[:userId])
	      if access_request.save
	        flash[:notice] = 'Request was made successfully.'
	        redirect_to "/home"
	      else
	        flash[:notice] = @access_request.errors
	        redirect_to "/home"
	      end
  	end

  	def approve

  	end
end
