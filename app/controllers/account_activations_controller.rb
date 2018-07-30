class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user&.authenticated?(:activation, params[:id]) && !user.activated?
      user.activate
      flash[:success] = t ".account_activated"
      log_in user
      redirect_to user
    else
      flash[:danger] = t ".invalid_activation_link"
      redirect_to root_path
    end
  end
end
