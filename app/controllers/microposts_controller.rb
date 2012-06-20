class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, :admin_user, only: :destroy

  def index
    @search = params[:search]
    @microposts = Micropost.search(@search)
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost.reply_cnt = 0

    if @micropost.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'sessions/new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Post deleted."
    redirect_to @micropost.user(root_path)
  end

  private

  def correct_user
    @micropost = Micropost.find_by_id(params[:id])
    ###
       allReplies = Reply.all

    ###
    redirect_to root_path if @micropost.nil?
  end

  def admin_user
    @micropost = Micropost.find_by_id(params[:id])
    redirect_to(@micropost.user(root_path)) unless current_user.admin?
  end
end