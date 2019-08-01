require 'json'

AppEnvironment.get_environment_variables

When("navigate to the Conductor login page") do
  begin
    config_driver = ConfigDriver.new("chrome")
    @driver = config_driver.get_driver
    @wait = config_driver.get_wait

    @conductor_page = ConductorPage.new(@driver, @wait)
    @conductor_page.open_page
  rescue Exception => e
    Screenshot.take("navigate to the Conductor login page", @driver)
    raise e
  end
end

When("login") do
  begin
    @conductor_page.login(ENV['CONDUCTOR_USER'], ENV['CONDUCTOR_PASSWORD'])
  rescue Exception => e
    Screenshot.take("login", @driver)
    raise e
  end
end

When("go to list accounts and search account using cpf") do
  @conductor_page.click_on_accounts
  @conductor_page.click_on_to_list
  @conductor_page.fill_cpf(ENV['CPF'])
  @conductor_page.click_on_to_fill

  @conductor_page.click_on_to_view
  @conductor_page.click_on_carne
  @conductor_page.click_on_to_fill
end

Then("carnê is show") do
  sleep 2
  @conductor_page.has_grid_data(ENV['CPF'])
end
