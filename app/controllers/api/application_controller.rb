class Api::ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  protect_from_forgery with: :null_session

  private

  def current_user
    User.find_by_email!(params[:email])
  end

  def record_not_found
      render json: { error: "Record not found" }, status: 404
  end
end
