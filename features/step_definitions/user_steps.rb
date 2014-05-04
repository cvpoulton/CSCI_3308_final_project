Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    new_user = User.new(user)
    new_user.password_confirmation = user[:password] # Have confirmed password for create
    new_user.walldate = Time.now # Add walldate
    new_user.save!
  end
end

Given /the following pending friendships exist/ do |pending_friends_table|
  pending_friends_table.hashes.each do |pending_friend|
    PendingFriendship.create!(pending_friend)
  end
end

Given /the following friendships exist/ do |friends_table|
  friends_table.hashes.each do |friend|
    Friendship.create!(friend)
  end
end

Given /the following posts exist/ do |posts_table|
  posts_table.hashes.each do |post|
    new_post = Post.new(post)
    new_post.time = Time.now
    new_post.save!
  end
end

Given /I am logged in as "(.*)" with password "(.*)"$/ do |user, pass|
  visit(login_url)
  fill_in("Username", :with => user)
  fill_in("Password", :with => pass)
  click_button("Login")
  @current_user_id = User.find(:all, :conditions => {:username => user, :password => pass})[0].id
end

Then /^my interests should be "(.*?)"$/ do |interests|
  assert User.find(@current_user_id).interests == interests
end

Then /^my quotes should be "(.*?)"$/ do |quotes|
  assert User.find(@current_user_id).quotes == quotes
end
