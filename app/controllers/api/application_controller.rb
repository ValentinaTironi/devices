class Api::ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  def current_user
    User.find_by_email!(params[:email])
  end
end
