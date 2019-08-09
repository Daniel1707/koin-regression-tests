require 'selenium-webdriver'

class ConfigDriver

  @brownser = "chrome"

  def initialize(brownser)
    @brownser = brownser
  end

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 600
  chrome_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome()
  $chrome = Selenium::WebDriver.for(:remote, :url => 'http://hub:4444/wd/hub', :desired_capabilities => chrome_capabilities, :http_client => client)
  $wait = Selenium::WebDriver::Wait.new()

  def get_driver
    return $chrome
  end

  def get_wait
    return $wait
  end
end
