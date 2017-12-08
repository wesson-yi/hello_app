class SignupsController < ApplicationController
  def create
    @signup = Sign.new(params[:signup])

    if @signup
      redirect_to dashboard_path
    else
      render 'new'
    end
  end
end
