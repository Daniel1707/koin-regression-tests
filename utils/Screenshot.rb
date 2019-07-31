class Screenshot
  def self.take(step_name, driver)
    driver.save_screenshot("Screenshots/#{step_name}.png")
  end
end
