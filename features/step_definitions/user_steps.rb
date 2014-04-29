Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
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
