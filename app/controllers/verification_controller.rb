class VerificationController < ApplicationController

  require 'uri'
  require 'nokogiri'

  before_action :authenticate_user!

  def create
    @domain = current_user.domains.find(params[:domain_id])

    @url = @domain.url

    if !URI.parse(@url).host
      @url = "http://" + @url
    end


    @doc = Nokogiri::HTML(HTTParty.get(@url))

    @verification = @doc.xpath("//meta[@name='easyData_verification']")

    if @verification.present? && @verification.first["content"] == @domain.verification_token
      @domain.update_attribute(:verified, true)
      redirect_to @domain, notice: "Domain successfully verified"
    else
      redirect_to @domain, notice: "Could not find the verification code in #{@domain.url}"
    end
  end
end