def create_user
  @user = User.new({:name => "Sandu Catalina", :email =>"sanducatalina10@yahoo.com", :password => "catalina",
   :password_confirmation => "catalina", :phone => "1234567890", :address => "Dumbraveni", :role => 1})
  @user.save
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @user[:email]
  fill_in "user_password", :with => "catalina"
  click_button "Log in"
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I am not logged in$/ do
  visit '/users/sign_up'
end

When /^I sign in with valid data$/ do
  sign_in
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

When /^I return to the site$/ do
  visit '/'
end

Then /^I should be signed in$/ do
  page.should have_content "Log out"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Given /^I have no menus$/ do
  Menu.delete_all
end

Given /^I have no restaurant$/ do
  Restaurant.delete_all
end

Given /^I go to the list of menus$/ do
  visit menus_path
end

Given /^I go to the list of restaurants$/ do
  visit restaurants_path
end

When(/^I follow "([^"]*)"$/) do |link|
click_link link
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, content|
  page.fill_in field, with: content
end

When(/^I select "(.*)" from "(.*)"$/) do |value, field|
  select(value, :from => field)
end

Then /^show me the page$/ do
  save_and_open_page
end

When(/^I press "([^"]*)"$/) do |button|
click_button button
end

Then /^I should see "([^"]*)"$/ do |text|
page.should have_content text
end

Then(/^I should have (\d+) menu$/) do |count|
  Menu.count.should eql count.to_i
end

Given /^I have orders titled (.+)$/ do |title|
  Order.create!(order_status: title, user_id: @user.id)
end

When /^I go to the list of orders$/ do
  visit orders_path
end

Then(/^I should have (\d+) order$/) do |count|
  Order.count.should eql count.to_i
end
