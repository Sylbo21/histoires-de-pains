class AccountController < ApplicationController

  before_action :ensure_authenticated

  def show
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to account_path
  end

  private

  def user_params
    params.require(:user).permit(:fist_name, :last_name, :email, :phone, :address, :npa, :city)
  end

end
