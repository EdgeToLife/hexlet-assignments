# frozen_string_literal: true

require 'rack/runtime'

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)
    x_runtime = headers['X-Runtime']
    runtime = x_runtime.to_f * 1000
    response_body = response.join + "\n#{runtime.to_s}" + " ms\n"
    [status, headers, [response_body]]
    # END
  end
end
