class HomeController < ApplicationController
    before_action :set_user, except: [:front, :about]
    respond_to :html, :js
  
    def index 
      @post = Post.new
      @friends = @user.all_following.unshift(@user)
      @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).paginate(:page => params[:page], :per_page => 100)
    end

    def search 
        @users = User.search(params[:search])
    end
  
    def front
    end
  
    def find_friends
      @friends = @user.all_following
      @users =  User.where.not(id: @friends.unshift(@user)).paginate(:page => params[:page], :per_page => 10)
    end
  
    private
    def set_user
      @user = current_user
    end
end