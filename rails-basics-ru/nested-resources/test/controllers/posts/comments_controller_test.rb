require "test_helper"

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = @post.comments.create(body: :one)
  end

  test "should get new" do
    get new_post_comment_url(@post)
    assert_response :success
  end

  test "should create comment" do
    assert_difference("PostComment.count") do
      post post_comments_url(@post), params: { post_comment: { body: @comment.body } }
    end

    assert_redirected_to post_url(@post)
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { post_comment: { body: @comment.body } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy comment" do
    assert_difference("PostComment.count", -1) do
      delete comment_url(@comment.id)
    end
    assert_redirected_to post_url
  end
end
