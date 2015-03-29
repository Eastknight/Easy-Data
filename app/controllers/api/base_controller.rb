class Api::BaseController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  before_action :authenticate_from_user_token!
  before_action :authenticate_user!


  def authenticate_from_user_token!
    if request.method != "OPTIONS"
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
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = "POST, GET, OPTIONS"
    headers['Access-Control-Allow-Headers'] = "Content-Type"
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
    headers['Access-Control-Max-Age'] = '1728000'
    render text: "" if request.method == "OPTIONS"
  end
end
