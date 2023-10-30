# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  attr_accessor :url
  include Comparable
  extend Forwardable
  def_delegators :@url, :scheme, :host, :port

  def initialize(str)
    @url = URI(str)
  end

  def query_params()
    if url.query
      query = url.query
      params = URI.decode_www_form(query).to_h
      params.transform_keys(&:to_sym)
    else
      params = {}
    end
  end

  def query_param(key, var = nil)
    result = nil
    if query_params.key?(key)
      result = query_params[key]
    else
      result = var
    end
    result
  end

  def ==(other)
    scheme == other.scheme &&\
    host == other.host && \
    port == other.port && \
    query_params.sort == other.query_params.sort
  end
end
# END
