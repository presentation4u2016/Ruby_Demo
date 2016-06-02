require 'selenium-webdriver'
require 'rspec'

describe "LivingSocial-SignUp" do
before(:all) do
	@driver = Selenium::WebDriver.for:phantomjs
	@driver.manage.window.maximize
	@driver.navigate.to "http://livingsocial.com"
	@wait = Selenium::WebDriver::Wait.new(:timeout => 30)
end

after(:all) do
	
end

it "Verify User is able to SignUP using Credentials" do
#checkinf if user is on the right homepage	
	@wait.until{@driver.find_element(:link_text, 'sign up')}
	expect(@driver.find_element(:link_text, 'sign up').displayed?).to be true
	@driver.find_element(:link_text, 'sign up').click
#checking if user is navigated to register page
	@wait.until{@driver.find_element(:xpath, ".//*[contains(@id,'register')]/fieldset/h3")}
	expect(@driver.find_element(:xpath, ".//*[contains(@id,'register')]/fieldset/h3").displayed?).to be true
#updating register page for sign up
	@driver.find_element(:id, 'first_name').send_keys "Natarajan"
	@driver.find_element(:id, 'last_name').send_keys "Ramanathan"
	@driver.find_element(:id, 'email').send_keys "natarajan.ramanathan93@gmail.com"
	@driver.find_element(:id, 'password').send_keys "Welcome@123"
	@driver.find_element(:id, 'password_confirmation').send_keys "Welcome@123"
#click on the email updates checkbox
	@driver.find_element(:id, 'subscribe')
#click on the Signup Button	
	@driver.find_element(:xpath, "//button[contains(@type,'submit')]").click
#check if registration is successful
	begin
	expect(@driver.find_element(:xpath, "//span[contains(@text, 'my vouchers')]").displayed?).to be true
	rescue
	fail
	end
end
it "verify User is able to Login" do
end
end
