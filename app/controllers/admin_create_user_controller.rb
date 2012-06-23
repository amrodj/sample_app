class AdminCreateUserController < ApplicationController
  def index
    @user = User.new
  end
end