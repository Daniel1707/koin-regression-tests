require 'selenium-webdriver'

class CheckoutPage

  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def openPage(url)
    @driver.get url
    sleep 1
  end

  def fill_birthdate(birthdate)
    birthdate_field = @wait.until { @driver.find_element(:id, "birthdate") }
    birthdate_field.send_keys(birthdate)
  end

  def click_on_in_cash
    in_cash_button = @wait.until { @driver.find_element(:xpath, "//label[text()='À Vista']") }
    in_cash_button.click
  end

  def click_on_finish_purchase
    in_cash_button = @wait.until { @driver.find_element(:xpath, "//label[text()='Finalizar compra']") }
    in_cash_button.click
  end
end
