class AccessRequestsController < ApplicationController
  protect_from_forgery with: :exception
    
  	def new
  		@requester = User.find(params[:currentUserId])
        @requested = User.find(params[:userId])

        access_request = AccessRequest.new()
        access_request.requester = @requester
        access_request.requested = @requested
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
