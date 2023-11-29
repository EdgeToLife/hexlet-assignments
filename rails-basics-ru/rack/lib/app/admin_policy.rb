# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)
    if env['PATH_INFO'] =~ %r{^/admin}
      [403, {}, []]
    else
      [status, headers, response]
    end
    # END
  end
end
