require 'ransack/helpers'

module ViewComponent::ViewHelpers
  extend ActiveSupport::Concern

  included do
    include Ransack::Helpers::FormHelper if defined? Ransack::Helpers
    include ApplicationHelper
    include ImageHelper
  end

  def attachment_image_tag(attachment, **options)
    if attachment&.attached?
      image_tag attachment, options
    else
      image_pack_tag 'media/images/logo.png', options
    end
  end

  def icon(name, options = {})
    inline_svg_pack_tag ['media/icons/', name, '.svg'].join, options
  end

  def flashes
    content = ''

    @flash.to_h.each do |key, content|
      content_tag(:div, class: "alert alert-#{key} alert-dismissable", role: 'alert') do
        [
          content_tag(:span, icon('x'), class: 'close', data: { dismiss: 'alert'}),
          flash[:success]
        ].join.html_safe
      end
    end

    content_tag(:div, id: 'flash-root') { content }
  end

  def flash(**flashes)
    @flash = flashes
  end

  def current_organization
    @current_organization ||= Organization.find_by_id(session[:current_organization_id])
  end

  def organization_selected?
    current_organization.present?
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by_id(session['warden.user.user.key']&.first&.first)
  end

  def current_user_id
    session['warden.user.user.key'].first.first
  end

  def render_flash(**flashes)
    return if flashes.empty?

    FlashRenderer.render(
      type: flashes.keys.first,
      content: flashes.values.first,
      to: current_user.id,
      async: false
    )
  end

  def render_toast(**toasts)
    return if toasts.empty?

    ToastRenderer.render(
      type: toasts.keys.first,
      body: toasts.values.first,
      to: current_user.id,
      async: false
    )
  end

  def combine_options(options, opts)
    options.deeper_merge(opts, extend_existing_arrays: true)
  end

  # here for action text to work
  def main_app
    Rails.application.class.routes.default_url_options[:host] = 'lvh.me:3000'
    Rails.application.class.routes.url_helpers
  end
end
