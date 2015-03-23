class Api::BaseController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  before_action :authenticate_from_user_token!
  before_action :authenticate_user!

  def authenticate_from_user_token!

    if request.method == "POST"
      token = params[:auth_token]
      user = User.where(authentication_token: token).first

      if user
        sign_in user, store: false
      else
        render json: {error: "Unauthorized"},status: :unauthorized and return
      end
    end
  end

  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Content-Type'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
end
