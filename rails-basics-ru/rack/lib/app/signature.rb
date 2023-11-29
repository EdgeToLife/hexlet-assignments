# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)
    hash = Digest::SHA256.hexdigest response.join.to_s
    response_body = response.join + "\n" + hash
    [status, headers, [response_body]]
    # END
  end
end
