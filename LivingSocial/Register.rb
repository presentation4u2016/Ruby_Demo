require 'selenium-webdriver'
require 'rspec'

describe "LivingSocial-SignUp" do
before(:each) do
	@driver = Selenium::WebDriver.for:phantomjs
	@driver.manage.window.maximize
	@driver.navigate.to "http://livingsocial.com"
	@wait = Selenium::WebDriver::Wait.new(:timeout => 30)
end

after(:each) do
	@driver.quit
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
	@driver.find_element(:id, 'last_name').send_keys "Presentation"
	@driver.find_element(:id, 'email').send_keys "presentation4u2016@gmail.com"
	@driver.find_element(:id, 'password').send_keys "Welcome@123"
	@driver.find_element(:id, 'password_confirmation').send_keys "Welcome@123"
#click on the email updates checkbox
	@driver.find_element(:id, 'subscribe')
#click on the Signup Button	
	@driver.find_element(:xpath, "//button[contains(@type,'submit')]").click
#check if registration is successful
	begin
	@wait.until{@driver.find_element(:link_text, 'my vouchers')}
	expect(@driver.find_element(:link_text,'my vouchers').displayed?).to be true
	rescue 
	fail "Account creation credentials is wrong or an account already exist"
	end
end

it "verify User is able to Login" do
#checking if user is on the homepage
	@wait.until{@driver.find_element(:link_text, 'log in')}
	expect(@driver.find_element(:link_text, 'log in').displayed?).to be true
	@driver.find_element(:link_text, 'log in').click
#checking if user is navigated to login page
	@wait.until{@driver.find_element(:xpath, ".//*[contains(@id,'login')]/fieldset/h3")}
#updating Login Credentials
	@driver.find_element(:id, 'login_email').send_keys "presentation4u2016@gmail.com"
	@driver.find_element(:id, 'login_password').send_keys "Welcome@123"
	@driver.find_element(:xpath, ".//button[contains(@id,'login')]").click
#check if Login is Successful
	begin
	@wait.until{@driver.find_element(:link_text, 'my vouchers')}
	expect(@driver.find_element(:link_text,'my vouchers').displayed?).to be true
	rescue 
	fail "Account doesn't exist or credentials is wrong"
	end
#choosing a category
	@wait.until{@driver.find_element(:css, ".deal-details>h2")}
	@driver.find_element(:css, ".deal-details>h2").click
	@driver.find_element(:link_text, 'book now').click
	dropDownMenu = @driver.find_element(:id, 'checkout_order_quantities_8716918')
	option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
	option.select_by(:index, 2 )
	@driver.find_element(:xpath, "//button[@id='checkout_form_buy']").click
end
end
