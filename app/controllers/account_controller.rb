class AccountController < ApplicationController

  before_action :ensure_authenticated

  def show
  end

  def edit
  end

  def update
  end

  def ensure_authenticated
    redirect_to login_path unless(logged_in?)
  end
end
