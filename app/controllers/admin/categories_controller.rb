class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, :verify_staff
  before_action :load_category, only: %i(edit update destroy)
  before_action :verify_admin, except: :index

  def index
    @categories = Category.by_latest.page(params[:page]).per Settings.show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".add_success", name: @category.name
      redirect_to admin_categories_path
    else
      flash.now[:warning] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".category_update"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t ".not_found"
      redirect_to admin_categories_path
    end
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".not_found", id: params[:id]
    redirect_to admin_categories_path
  end

  def category_params
    params.require(:category).permit :name, :price, :description
  end
end
