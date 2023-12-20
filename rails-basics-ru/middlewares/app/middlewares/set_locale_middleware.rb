# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)

    locale = get_locale(env)

    if env['PATH_INFO'] == '/index.html'
      env['PATH_INFO'] = "/index.#{locale}.html"
    end

    @app.call(env)

  end

  private

  def get_locale env
    locale = env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first || I18n.default_locale
    I18n.locale = if I18n.available_locales.include?(locale.to_sym)
                    locale
                  else
                    I18n.default_locale
                  end
  end
  # END
end
