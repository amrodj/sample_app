class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def search
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
    redirect_to root_path
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    ###
       allReplies = Reply.all

    ###
    redirect_to root_path if @micropost.nil?
  end
end