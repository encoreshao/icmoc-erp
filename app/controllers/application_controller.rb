# frozen_string_literal: true

class Unauthorized < RuntimeError; end

class ApplicationController < ActionController::Base
  include PermissionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_controller

  before_action :authenticate_user!

  rescue_from ::Unauthorized, with: :deny_access
  rescue_from ::ActionView::MissingTemplate, with: :missing_template

  around_action :switch_locale, if: proc { !devise_controller? }
  before_action :authorize, if: proc { !devise_controller? }

  def switch_locale(&action)
    locale = current_user&.locale || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def deny_access
    current_user.nil? ? render_403 : redirect_to(root_path)
  end

  # Authorize the user for the requested action
  def authorize(ctrl = params[:controller], action = params[:action], _global = false)
    allowed = current_user.roles.map do |role|
      role.allowed_to?({ controller: ctrl, action: action })
    end.include?(true)

    if allowed
      true
    else
      if @project&.archived?
        render_403 message: :notice_not_authorized_archived_project
      else
        deny_access
      end
    end
  end

  # Authorize the user for the requested action outside a project
  def authorize_global(ctrl = params[:controller], action = params[:action], global = true)
    authorize(ctrl, action, global)
  end

  def back_url
    url = params[:back_url]
    if url.nil? && referer = request.env['HTTP_REFERER']
      url = CGI.unescape(referer.to_s)
    end
    url
  end

  def redirect_back_or_default(default, options = {})
    back_url = params[:back_url].to_s
    if back_url.present? && valid_back_url?(back_url)
      redirect_to(back_url)
      return
    elsif options[:referer]
      redirect_to_referer_or default
      return
    end
    redirect_to default
    false
  end

  # Returns true if back_url is a valid url for redirection, otherwise false
  def valid_back_url?(back_url)
    return false if CGI.unescape(back_url).include?('..')

    begin
      uri = URI.parse(back_url)
    rescue URI::InvalidURIError
      return false
    end

    return false if uri.host.present? && uri.host != request.host

    return false if uri.path =~ %r{/(login|account/register)}

    if relative_url_root.present? && !uri.path.starts_with?(relative_url_root)
      return false
    end

    true
  end
  private :valid_back_url?

  # Redirects to the request referer if present, redirects to args or call block otherwise.
  def redirect_to_referer_or(*args)
    redirect_to :back
  rescue ::ActionController::RedirectBackError
    if args.any?
      redirect_to *args
    elsif block_given?
      yield
    else
      raise '#redirect_to_referer_or takes arguments or a block'
    end
  end

  def render_403(options = {})
    @project = nil
    render_error({ message: :notice_not_authorized, status: 403 }.merge(options))
    false
  end

  def render_404(options = {})
    render_error({ message: :notice_file_not_found, status: 404 }.merge(options))
    false
  end

  # Renders an error response
  def render_error(arg)
    arg = { message: arg } unless arg.is_a?(Hash)

    @message = arg[:message]
    @message = l(@message) if @message.is_a?(Symbol)
    @status = arg[:status] || 500

    respond_to do |format|
      format.html do
        render template: 'common/error', layout: use_layout, status: @status
      end
      format.any { head @status }
    end
  end

  # Handler for ActionView::MissingTemplate exception
  def missing_template
    logger.warn 'Missing template, responding with 404'
    @project = nil
    render_404
  end

  protected

  def layout_by_controller
    devise_controller? ? 'devise' : 'application'
  end
end
