require 'rubygems'
require 'selenium-webdriver'
desc "upgrade shenqi"
task :upgrade => :environment do

	driver = Selenium::WebDriver.for :firefox
	base_url = "http://bbs.sgamer.com/forum-@-$.html"

	driver.navigate.to "http://bbs.sgamer.com/forum-54-2.html"

	base = driver.window_handle
	element = driver.find_element(:class, 'fastlg_btn')
	element.click

	puts "click enter when you are ready..."
	code = $stdin.gets
	puts "Now we are in a logged in page"


	driver.find_elements(:tag_name, "a").each do |l|
		begin
			if l.attribute('href').start_with?("http://bbs.sgamer.com/thread-") and (not l.text.strip=~/\A[0-9]+\Z/) and l.text.present?
				# puts l.text
				l.click
				windows = driver.window_handles
				windows.delete(base)
				driver.switch_to.window(windows.first)
				ele = driver.find_element(:id, 'vmessage')
				if ele.present?
					ele.clear
					message = nil
					message = driver.find_elements(:css, "[id^=postmessage_]").third.text if driver.find_elements(:css, "[id^=postmessage_]").third
					message ||= driver.find_elements(:css, "[id^=postmessage_]").second.text if driver.find_elements(:css, "[id^=postmessage_]").second
					message ||= " kill 0 reply"

					ele.send_keys(message)

					ele = driver.find_element(:id, 'vreplysubmit')
					if ele.present?
						sleep(3)
						ele.click
					end
				end
				driver.close
				driver.switch_to.window(base)
			end
		rescue
			driver.close
			driver.switch_to.window(base)
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