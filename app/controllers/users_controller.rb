class UsersController < ApplicationController
    
    def create
        @user = User.new(name: params[:user][:name])
        if params[:user][:password] == params[:user][:password_confirmation]
            @user.password = params[:user][:password]
            @user.save
            session[:user_id] = @user.id
        else
            redirect_to action: 'new'
        end
    end

    def index
        @users = User.order(:email)
        respond_to do |format|
            format.html { render :index }
            format.json { render json: @users }
        end
    end
    
    def show
        set_user
        unless current_user.id == @user.id || @user.received_access_requests.any? {|r| r.requester_id == current_user.id && r.isApproved == true}
            flash[:notice] = "You don't have access to that User's Collection!"
            redirect_to "/home" 
            return
        end
    end

    def home
        @access_requests = current_user.received_access_requests
        @borrow_requests = current_user.received_borrow_requests
        recently_returned = current_user.artists.where(recentlyReturned: true)
        if recently_returned.count > 0
            message = "Recently returned artists: "
            recently_returned.each do |artist|
                message += artist.name + "  "
                artist.recentlyReturned = false
                artist.save
            end 
        end
        flash[:notice] = message
    end

    def current
        render json: current_user 
    end

    private
    
    def set_user
        @user = User.find(params[:id])
    end
end