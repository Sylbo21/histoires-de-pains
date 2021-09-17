class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if(user.present? && user.authenticate(params[:password]))
      session[:user_id] = user.id
      # change redirect_to 'My Account'
      redirect_to root_path
    else
      flash[:alert] = "L'email et/ou le mot de passe ne sont pas valides. Veuillez réessayer."
      render 'new'
    end
  end

  def destroy
  end
end
