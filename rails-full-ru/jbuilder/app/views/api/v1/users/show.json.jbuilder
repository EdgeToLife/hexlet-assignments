json.extract! @user, :id, :email, :address
json.full_name "#{@user.first_name} #{@user.last_name}"
json.posts @user.posts do |post|
  json.partial! 'api/v1/users/posts', post: post
end
