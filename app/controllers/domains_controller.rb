class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @domains = Domain.all
    respond_with(@domains)
  end

  def show
    respond_with(@domain)
  end

  def new
    @domain = Domain.new
    respond_with(@domain)
  end

  def edit
  end

  def create
    @domain = Domain.new(domain_params)
    @domain.save
    respond_with(@domain)
  end

  def update
    @domain.update(domain_params)
    respond_with(@domain)
  end

  def destroy
    @domain.destroy
    respond_with(@domain)
  end

  private
    def set_domain
      @domain = Domain.find(params[:id])
    end

    def domain_params
      params.require(:domain).permit(:name, :url)
    end
end
