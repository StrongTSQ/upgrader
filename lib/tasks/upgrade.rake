require 'rubygems'
require 'selenium-webdriver'
desc "upgrade shenqi"
task :upgrade => :environment do

	driver = Selenium::WebDriver.for :firefox
	driver.navigate.to "http://bbs.sgamer.com/forum-44-1.html"

	base = driver.window_handle
	element = driver.find_element(:class, 'fastlg_btn')
	element.click

	puts "click enter when you are ready..."
	code = $stdin.gets
	puts "Now we are in a logged in page"

	driver.find_elements(:tag_name, "a").each do |l|
		begin
			if l.attribute('href').start_with?("http://bbs.sgamer.com/thread-1182") and (not l.text=~/\A[0-9]+\Z/)
				l.click
				windows = driver.window_handles
				windows.delete(base)
				driver.switch_to.window(windows.first)
				ele = driver.find_element(:id, 'vmessage')
				ele.send_keys("I will never be in the XHW")
				ele = driver.find_element(:id, 'vreplysubmit')
				ele.click
				driver.close
				driver.switch_to.window(base)
			end
		rescue
			puts "one error happens"
		end
	end


	# element = driver.find_element(:name, 'username')
	# element.send_keys('strongtsq')

	# element = driver.find_element(:name, 'password3')
	# element.send_keys('tsq000')
	
	# puts "enter verification code"
	# code = $stdin.read

	# element = driver.find_element(:name, 'seccodeverify')
	# element.send_keys(code)

	# element = driver.find_element(:name, 'loginsubmit')
	# element.click




	# driver.quit

end