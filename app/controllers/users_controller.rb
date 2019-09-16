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
        unless current_user.id == @user.id
            flash[:notice] = "You don't have access to that User's Collection!"
            redirect_to "/home" 
            return
        end
    end

    def home
        @access_requests = current_user.received_access_requests
    end

    def current
        render json: current_user 
    end

    private
    
    def set_user
        @user = User.find(params[:id])
    end
end