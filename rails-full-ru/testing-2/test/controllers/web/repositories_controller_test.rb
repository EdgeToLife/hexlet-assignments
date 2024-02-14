# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  # BEGIN
  def setup
    fixture_path = 'files/response.json'
    @fixture_data = load_fixture(fixture_path)
  end

  test 'should_create' do
    repository_params = { repository: { link: 'https://github.com/EdgeToLife/rails-project-65' } }
    stub_request(:get, "https://api.github.com/repos/EdgeToLife/rails-project-65").
    with(
      headers: {
            'Accept'=>'application/vnd.github.v3+json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json',
            'User-Agent'=>'Octokit Ruby Gem 5.6.1'
      }).
    to_return(status: 200, body: @fixture_data, headers: { 'Content-Type': 'application/json' })

    post repositories_url, params: repository_params

    assert_redirected_to repositories_path
    assert_equal 'Success', flash[:notice]
  end
  # END
end
