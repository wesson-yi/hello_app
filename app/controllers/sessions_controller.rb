class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])

    if UserAuthenticator.new(user).authenticate(params[:password])
      self.current_user = user
      redirect_to dashboard_path
    else
      flash[:alert] = 'Login failed.'
      render 'new'
  end
end
