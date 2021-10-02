class AccountController < ApplicationController

  before_action :ensure_authenticated

  def show
  end

  def edit
  end

  def update
    current_user.update(account_params)
    redirect_to account_path
  end

  private

  def account_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :address, :npa, :city)
  end

end
