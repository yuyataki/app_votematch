class ErrorsController < ActionController::Base
  layout 'application'

  rescue_from StandardError, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  %w(404 500).each do |status_code|
    define_method("render_#{status_code}") do |exception = nil|
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render(
      file: Rails.root.join('public/404.html'),
      status: 404, layout: false, content_type: 'text/html'
    )
    end
  end

  def show
    raise env['action_dispatch.exception']
  end
end
