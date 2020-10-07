class ReflexComponent < ViewComponentReflex::Component
  # here for action text to work
  def main_app
    Rails.application.class.routes.default_url_options[:host] = 'lvh.me:3000'
    Rails.application.class.routes.url_helpers
  end
end
