# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'net/https'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      uri = URI('https://rails-collective-blog-ru.hexlet.app')
      sign_path = 'users/sign_up'
      users_path = 'users'

      puts "\nEmail: #{email}, Password: #{password}\n\n"

      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        request = Net::HTTP::Get.new uri.request_uri + sign_path

        response = http.request request

        html = Nokogiri::HTML(response.body)

        # csrf_token = html.css('meta[name="csrf-token"]').attr('content').value
        # authenticity_token = html.css('input[name="authenticity_token"]').attr('value').value
        # debugger
        # csrf_token = html.at('meta[name="csrf-token"]').attr('content')
        authenticity_token = html.at('input[name="authenticity_token"]').attr('value')
        # at_css('input[name="authenticity_token"]')['value']

        cookie = response.response['set-cookie'].split('; ')[0]

        # puts "::::::::COOKIES:::::::::>>>>#{response.response['set-cookie']}<<<<::\n"
        # puts "::::::PARSED COOKIE:::::>>>>#{cookie}<<<<::\n"
        # # puts ":::::::CSRF TOKEN:::::::>>>>#{csrf_token}<<<<::\n"
        # puts ":::AUTHENTICITY TOKEN:::>>>>#{authenticity_token}<<<<::\n\n\n"

        # puts response.body.force_encoding('UTF-8')
        # puts "\n\nОЛОЛОШ\n\n"

        params = {
          'authenticity_token' => authenticity_token,
          'user[email]' => email,
          'user[password]' => password,
          'user[password_confirmation]' => password,
          'commit' => 'Регистрация'
        }

        headers = {
          'authority' => 'rails-collective-blog-ru.hexlet.app',
          'accept' => 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml',
          'content-type' => 'application/x-www-form-urlencoded;charset=UTF-8',
          'origin' => 'https://rails-collective-blog-ru.hexlet.app',
          'referer' => 'https://rails-collective-blog-ru.hexlet.app/users/sign_up',
          # 'x-csrf-token' => csrf_token
        }

        request = Net::HTTP::Post.new uri.request_uri + users_path
        request.body = URI.encode_www_form(params)
        request['Cookie'] = cookie
        headers.each { |key, value| request.add_field(key, value) }

        # debugger

        response = http.request request

        # puts response.code
        # puts "\n\n"
        # debugger

        # puts response.body

        # response.code == '200'
      end

    end
    # END
  end
end
