#!/usr/bin/ruby


email = ENV['EMAIL'] 
pass = ENV['PASS']

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

# Yahooを開く
driver.get('https://hangouts.google.com/hangouts/_/gsacademy.com/gsa-class-1?hl=en&authuser=0')
sleep 5
driver.find_elements(xpath: "//*[contains(text(), 'Join')]")[0].click
sleep 10 

## ちゃんと開けているか確認するため、sleepを入れる
#sleep 2
#
##**
#  # ブラウザでさせたい動作を記載する
#
#  # ex. 検索欄に'Ruby'と入力して、検索ボタンを押す処理
#
#  # 検索欄/検索ボタン取得
#  begin
#    search_box = driver.find_element(:id, 'srchtxt') # 検索欄
#    search_btn = driver.find_element(:id, 'srchbtn') # 検索ボタン
#  rescue Selenium::WebDriver::Error::NoSuchElementError
#    p 'no such element error!!'
#    return
#  end
#
#  # 入力欄に'Ruby'を入力し、検索ボタンを押下
#  search_box.send_keys 'Ruby'
#  search_btn.click
##**

# ドライバーを閉じる
#driver.quit
