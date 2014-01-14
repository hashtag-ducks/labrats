class UsersController < ApplicationController
    before_filter :signed_in_user, only: [:edit, :update]
    before_filter :correct_user, only: [:edit, :update]

    def new
        @user = User.new
    end

    def create
        @user = User.new(params[:user])
        @user.organization = params[:user][:organization].capitalize
        if @user.save
            sign_in @user
            redirect_to @user
        else
            render 'new'
        end
    end

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @feed = []
        @user.notebooks.each do |n|
          n.page_templates.each do |t|
            @feed << t
          end
        end
    end

    def edit
    end

    def update
        if @user.update_attributes(user_params)
            flash[:success] = "Update complete"
            redirect_to @user
        else
            flash[:error] = "Invalid fields"
            render 'edit'
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end
end
