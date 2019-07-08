require 'selenium-webdriver'

class ConfigDriver

  @brownser = "chrome"

  def initialize(brownser)
    @brownser = brownser
  end

  #caps = Selenium::WebDriver::Remote::Capabilities.send(@brownser)
  #@driver = Selenium::WebDriver.for(:remote, url: "http://192.168.99.100:4444/wd/hub", desired_capabilities: caps)

  Selenium::WebDriver::Chrome::Service.driver_path=File.join(File.absolute_path(File.dirname(__FILE__)),"../driver","chromedriver.exe")

  options = Selenium::WebDriver::Chrome::Options.new#(args: ['headless'])
  options.add_argument('--ignore-certificate-errors')
  options.add_argument('--disable-popup-blocking')
  options.add_argument('--disable-translate')

  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('--disable-dev-shm-usage')
  $driver = Selenium::WebDriver.for :chrome, options: options
  $wait = Selenium::WebDriver::Wait.new(:timeout => 10)

  def get_driver
    return $driver
  end

  def get_wait
    return $wait
  end
end
