class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :update, :destroy ]
  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end
  def update
    @category.update!(category_params)
    render json: @category
  end

  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Record not found" }
  end

  def category_params
    if params[:category]
      params.require(:category).permit(:name)
    else
      params.permit(:name)
    end
  end
end
