class RatingsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_customer, only: :create
  before_action :load_rating, only: :destroy

  def create
    @rating = current_user.ratings.build rating_params
    if @rating.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".waning"
    end
    redirect_to root_url
  end

  def destroy
    if @rating.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to root_url
  end

  private

  def load_rating
    @rating = Rating.find_by id: params[:id]
    return if @rating
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def rating_params
    params.require(:rating).permit :content
  end
end
