class Api::EventsController < Api::BaseController

  def create
    puts request
    @domain = current_user.domain_from_caller(request.referer)

    if @domain.blank?
      render json: {status: "error"}, status: :forbidden
    else
      event = @domain.events.build(name: params[:name])
      event.save
      render json: {status: "ok"}, status: :created
    end
  end
end
