class UsersController < ApplicationController
  #Authorization
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      if :admin_user
        if @user.admin?
          flash[:success] = "Created Admin"
        else
          flash[:success] = "Created User"
        end
        redirect_to users_path
      else
        sign_in @user
        flash[:success] = "Welcome to the Backchannel App!"
        redirect_to @user
      end
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    if @user.update_attributes(params[:user])
      #successful update
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to users_path
  end


  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end