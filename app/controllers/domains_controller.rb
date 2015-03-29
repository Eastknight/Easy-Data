class DomainsController < ApplicationController
  before_action :authenticate_user!

  def index
    @domains = current_user.domains
  end

  def show
    @domain = current_user.domains.find(params[:id])
    @events = @domain.events
  end

  def new
    @domain = current_user.domains.build
  end

  def edit
    @domain = current_user.domains.find(params[:id])
  end

  def create
    @domain = current_user.domains.build(domain_params)
    if @domain.save
      redirect_to domain_url(@domain), notice: "Domain created. Please follow the instructions below to verify it."
    else
      render :new
    end
  end

  def update
    @domain = current_user.domains.find(params[:id])
    if @domain.update_attributes(domain_params)
      redirect_to domain_url(@domain), notice: "Domain updated."
    else
      render :edit
    end
  end

  def destroy
    @domain = current_user.domains.find(params[:id])
    @domain.destroy
    redirect_to domains_url, notice: "Domain deleted."
  end

  private

    def domain_params
      params.require(:domain).permit(:name, :url)
    end
end
