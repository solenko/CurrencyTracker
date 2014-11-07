Given /I logged in with "([^"]*)"/ do |email|
  step "user \"#{email}\" exists"
  visit "/users/sign_in"
  fill_in "user_email", :with => email
  fill_in "user_password", :with => '111111'
  click_button "Log in"
end

Given /user "([^"]*)" exists/ do |email|
  FactoryGirl.create(:user, :email => email) unless User.where(:email => email).any?
end

