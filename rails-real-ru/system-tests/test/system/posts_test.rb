# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test 'visiting the index' do
    visit root_url
    assert_selector 'h1', text: 'Home#index'
  end

  test 'creating a Post' do
    visit root_url

    click_on 'Posts'
    click_on 'New Post'

    fill_in 'Title', with: 'Test Post'
    fill_in 'Body', with: 'Test Body'

    click_on 'Create Post'

    assert_text 'Post was successfully created'
  end

  test 'updating a Book' do
    visit posts_url
    click_on 'Edit', match: :first

    fill_in 'Title', with: 'Updated Test Post'
    fill_in 'Body', with: 'Updated Test Body'

    click_on 'Update Post'

    assert_text 'Post was successfully updated'
  end

  test 'destroying a Book' do
    visit posts_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Post was successfully destroyed'
  end
end
# END
