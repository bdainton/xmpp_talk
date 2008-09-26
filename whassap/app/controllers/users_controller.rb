class UsersController < ApplicationController
  
  def index
  end
  
  def show
    @user = User.find_by_name(params[:id])
    @status = @user.statuses.new
  end
end
