require 'selenium-webdriver'

class ConductorPage

  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def open_page
    @driver.get ENV['CONDUCTOR_ENV']
    @driver.manage.window.maximize
    sleep 1
  end

  def login(user, password)
    userField = @wait.until { @driver.find_element(:xpath, "//input[@type='text']") }
    userField.send_keys(user)

    @driver.find_element(:xpath, "//input[@type='password']").send_keys(password)
    sleep 1
    @driver.find_element(:xpath, '//input[@value="Entrar"]').click
  end

  def click_on_accounts
    accounts = @wait.until { @driver.find_element(:xpath, "//div[text()='Contas']") }
    accounts.click
  end

  def click_on_to_list
    to_list = @wait.until { @driver.find_element(:xpath, "//a[text()='Listar']") }
    to_list.click
  end

  def fill_cpf(cpf)
    cpf_field = @wait.until { @driver.find_element(:xpath, "//input[@id='cpfFiltro']") }
    cpf_field.send_keys(cpf)
  end

  def click_on_to_fill
    to_fill = @wait.until { @driver.find_element(:xpath, "//input[@value='Filtrar']") }
    to_fill.click
  end

  def click_on_to_view
    sleep 2
    to_view = @wait.until { @driver.find_element(:xpath, "//img[@title='Visualizar']/../../a") }
    to_view.click
  end

  def click_on_carne
    sleep 2
    carne = @wait.until { @driver.find_element(:xpath, "//input[@value='Carnê']") }
    carne.click
  end

  def click_on_carne
    sleep 2
    carne = @wait.until { @driver.find_element(:xpath, "//input[@value='Carnê']") }
    carne.click
  end

  def has_grid_data(data)
    has_data = false

    begin
      @wait.until { @driver.find_element(:xpath, "//div[@id='idRelatorio']//td//span") }
      has_data = @driver.find_element(:xpath, "//div[@id='idRelatorio']//td//span").text.strip.include? data
    rescue
      has_data = false
    end

    return has_data
  end
end
