#!/usr/bin/ruby


email = ENV['EMAIL'] 
pass = ENV['PASS']
domain = ENV['DOMAIN']
room = ENV['ROOM']
duration = ENV['DURATION']

require 'selenium-webdriver'

@wait_time = 3 
@timeout = 4

# Initialize Selenium
# class ref: https://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Chrome
Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
Selenium::WebDriver.logger.level = :warn
driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = @timeout
wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)


url = "https://accounts.google.com/signin";
driver.get(url);

driver.find_element(id: "identifierId").send_keys(email)
driver.find_element(id: "identifierNext").click()
driver.find_element(name: "password").send_keys(pass)
element = driver.find_element(id: 'passwordNext')
driver.execute_script("arguments[0].click();", element)

sleep 2

driver.get("https://hangouts.google.com/hangouts/_/#{domain}/#{room}?hl=en&authuser=0")
sleep 5
driver.find_elements(xpath: "//*[contains(text(), 'Join')]")[0].click
sleep duration 

driver.quit
