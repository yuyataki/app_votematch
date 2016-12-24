class ErrorsController < ActionController::Base
  layout 'application'

  rescue_from StandardError, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render(
      file: Rails.root.join('public/404.html'),
      status: 404, layout: false, content_type: 'text/html'
    )
  end

  def render_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render(
      file: Rails.root.join('public/500.html'),
      status: 500, layout: false, content_type: 'text/html'
    )
  end

  def show
    raise env['action_dispatch.exception']
  end
end
