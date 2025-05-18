class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]
  def index
    @users = User.all
    render json: @users # { message: "Success", data: @users, count: @users.count }
  end
  def show
    render json: @user
  end
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update!(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      head :no_content  # proper HTTP 204 response for successful deletion
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Record not found" }
  end

  def user_params
    if params[:user]
      params.require(:user).permit(:name, :email)
    else
      params.permit(:name, :email)
    end
  end
end
