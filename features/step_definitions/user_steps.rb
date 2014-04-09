Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /I am logged in as "(.*)" with password "(.*)"$/ do |user, pass|
  visit(login_url)
  fill_in("Username", :with => user)
  fill_in("Password", :with => pass)
  click_link_or_button("Login")
  @current_user = User.find(:all, :conditions => {:username => user, :password => pass})[0]
end

Then /^my interests should be "(.*?)"$/ do |interests|
  assert @current_user.interests == interests
end

Then /^my quotes should be "(.*?)"$/ do |quotes|
  assert @current_user.quotes == quotes
end
