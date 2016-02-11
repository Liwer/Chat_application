class UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users.as_json(only: [:username, :id, :messages_count])}
    end
end

  def show
    @user = User.find(params[:id])
  end

end
