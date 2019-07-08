require 'selenium-webdriver'

class AquariusPage

  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def openPage
    @driver.get ENV['ACQUARIUS_ENV']
    sleep 1
  end

  def login(user, password)
    userField = @wait.until { @driver.find_element(:xpath, "//input[@type='text']") }
    userField.send_keys(user)

    @driver.find_element(:xpath, "//input[@type='password']").send_keys(password)
    sleep 1
    @driver.find_element(:xpath, '//button[text()="Entrar"]').click
  end

  def click_on_comunication_log
    @wait.until { @driver.find_element(:xpath, "//a[@permission='CONSULTAS']") }
    consultButton = @driver.find_element(:xpath, "//a[@permission='CONSULTAS']")
    sleep 3
    @driver.action.move_to(consultButton).perform
    @driver.find_element(:xpath, '//span[text()="Log de Comunicação "]').click
  end

  def clickOnManualAnalyse
    @wait.until { @driver.find_element(:xpath, "//a[@permission='CREDITO']") }
    creditoButton = @driver.find_element(:xpath, "//a[@permission='CREDITO']")
    sleep 3
    @driver.action.move_to(creditoButton).perform
    @driver.find_element(:xpath, '//span[text()="Análise Manual "]').click
  end

  def fill_comunication_log(cpf)
    cpfField = @wait.until { @driver.find_element(:xpath, "//input[@title='Digite o CPF a ser pesquisado']") }
    cpfField.send_keys(cpf)
    sleep 1
    @driver.find_element(:xpath, '//button[text()=" Consultar
						"]').click
  end

  def click_on_send_date
    sentDate = @wait.until { @driver.find_element(:xpath, "//a[@title='Exibe detalhes do log de e-mail']") }
    sentDate.click
  end

  def get_part_link_from_phone
    sentDate = @wait.until { @driver.find_element(:xpath, "//td[@title='phone']./td[1]") }
    sentDate.get_text
  end
end
