class AdminStatisticsController < ApplicationController
  def index
    @microposts = Micropost.all
    @users = User.all

    @average_number_comments_per_post = (Reply.count * 1.0 / Micropost.count)
    @average_number_posts_per_user = (Micropost.count * 1.0 / User.count)


  end
end