require 'selenium-webdriver'

class CheckoutPage

  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def open_page(url)
    @driver.get url
    @driver.manage.window.maximize
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
    in_cash_button = @wait.until { @driver.find_element(:xpath, "//button[text()='Finalizar compra']") }
    in_cash_button.click
  end

  def click_on_accept_terms
    accept_terms = @wait.until { @driver.find_element(:id, "idTermsAccepted") }
    accept_terms.click
  end

  def has_status_message(status)
    has_message = false

    begin
      @wait.until { @driver.find_element(:xpath, "/html/body") }
      has_message = @driver.find_element(:xpath, "/html/body").text.include? status
    rescue
      has_message = false
    end

    return has_message
  end
end
