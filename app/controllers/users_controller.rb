class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Backchannel App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    #@user = User.find(params[:id])
    #@microposts = @user.microposts.paginate(page: params[:page])
    redirect_to "/"
  end
end
