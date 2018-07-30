class CategoriesController < ApplicationController
  before_action :logged_in_user, :vetify_admin

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".add_success", name: @category.name
      redirect_to new_category_path
    else
      flash.now[:warning] = t ".create_fail"
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :price, :description
  end
end
