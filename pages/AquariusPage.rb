require 'selenium-webdriver'

class AquariusPage

  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def open_page
    @driver.get ENV['ACQUARIUS_ENV']
    @driver.manage.window.maximize
    sleep 1
  end

  def is_logged(user)
    sleep 2

    user_logged = false

    begin
      user_logged = @driver.find_element(:xpath, "//span[text()='#{user}']").displayed?
    rescue
    	user_logged = false
    end

    return user_logged
  end

  def login(user, password)

    user_name = ENV['AQUARIUS_NAME'].dup
    found_user_name = is_logged(user_name.force_encoding(Encoding::UTF_8))

    if found_user_name.eql? true
      logout
    end

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

    manual_analyse_button = @wait.until { @driver.find_element(:xpath, '//span[text()="Análise Manual "]') }
    manual_analyse_button.click
  end

  def fill_manual_analyse_filter_order(order)
    sleep 2
    order_field = @wait.until { @driver.find_element(:xpath, "//input[@title='Digite o número do pedido']") }
    order_field.send_keys(order)
    sleep 2
    @driver.find_element(:xpath, '//button[text()=" Consultar
                        "]').click
  end

  def click_on_consult
    consult_button = @wait.until { @driver.find_element(:xpath, '//button[text()=" Consultar
                        "]') }
    consult_button.click
  end

  def select_status_from_manual_analyse(status)
    sleep 1
    status_button = @wait.until { @driver.find_element(:xpath, "//button[@title='Selecione o tipo']") }
    status_button.click

    status = @driver.find_element(:xpath, "//button[@title='Selecione o tipo']/..//span[text()='#{status}']")
    status.click
  end

  def get_result_manual_analyse_data(name)

    found_data = false

    begin
      @wait.until { @driver.find_element(:xpath, "//td[text()='#{name}']") }
      found_data = true
    rescue
      found_data = false
    end

    return found_data
  end

  def click_on_start_manual_analyse
    sleep 2
    start_manual_analyse = @wait.until { @driver.find_element(:xpath, "//a[@title='Iniciar Análise']/i") }
    start_manual_analyse.click
  end

  def click_on_postpone
    postergar = @wait.until { @driver.find_element(:xpath, '//button[text()="Postergar"]') }
    postergar.click
  end

  def click_on_approve
    sleep 5
    approve = @wait.until { @driver.find_element(:xpath, '//button[text()="Aprovar"]') }
    approve.click
  end

  def click_on_disapprove
    sleep 5
    disapprove = @wait.until { @driver.find_element(:xpath, '//button[text()="Reprovar"]') }
    disapprove.click
  end

  def select_reason(reason)
    sleep 2
    click_reason = @wait.until { @driver.find_element(:xpath, "//button[@title='Selecione o Motivo']") }
    click_reason.click

    reason = @driver.find_element(:xpath, "//button[@title='Selecione o Motivo']/..//span[text()='#{reason}']")
    reason.click
  end

  def click_on_cancel
    cancel = @wait.until { @driver.find_element(:xpath, '//button[text()="Cancelar"]') }
    sleep 4
    cancel.click
  end

  def fill_limit(limit)
    limit_field = @wait.until { @driver.find_element(:xpath, "//input[@title='Digite o Limite']") }
    limit_field.clear
    limit_field.send_keys(limit)
  end

  def fill_observation(observation)
    observation_field = @wait.until { @driver.find_element(:xpath, '//label[text()="Observação"]/..//textarea') }
    observation_field.send_keys(observation)
  end

  def click_on_confirm
    sleep 3
    confirm = @wait.until { @driver.find_element(:xpath, '//button[text()=" Confirmar
				"]') }
    confirm.click
  end

  def fill_comunication_log(cpf)
    cpfField = @wait.until { @driver.find_element(:xpath, "//input[@title='Digite o CPF a ser pesquisado']") }
    cpfField.send_keys(cpf)
    sleep 3

    button = @wait.until { @driver.find_element(:xpath, '//button[text()=" Consultar
						"]') }
    button.click
  end

  def click_on_send_date
    sleep 2
    sentDate = @wait.until { @driver.find_element(:xpath, "//a[@title='Exibe detalhes do log de e-mail']") }
    sentDate.click
  end

  def get_part_link_from_phone
    sent_date = @wait.until { @driver.find_element(:xpath, "//td[text()='phone']/..//td[2]") }
    sent_date.text
  end

  def get_manual_analyse_text_field(label_text)
    sleep 3
    label_element = @wait.until { @driver.find_element(:xpath, "//label[text()='#{label_text}']/..//div/span") }
    label_element.text
  end

  def logout
    name_to_logout = @wait.until { @driver.find_element(:xpath, "//div[@ng-if='session.user']//a") }
    sleep 5
    name_to_logout.click

    exit = @wait.until { @driver.find_element(:xpath, '//span[text()="Sair"]') }
    exit.click
  end

  def click_on_transacao
    @wait.until { @driver.find_element(:xpath, "//a[@permission='OPERACOES']") }
    operations = @driver.find_element(:xpath, "//a[@permission='OPERACOES']")
    sleep 3
    @driver.action.move_to(operations).perform
    @driver.find_element(:xpath, '//span[text()="Transação "]').click
  end

  def search_by_cpf_transaction(cpf)
    sleep 1
    cpf_field = @wait.until { @driver.find_element(:xpath, "//input[@title='Digite o CPF do comprador a ser pesquisado']") }
    cpf_field.send_keys(cpf)
    sleep 3
    @driver.find_element(:xpath, '//button[text()=" Consultar
						"]').click
  end

  def has_data_transaction(data)
    found_data = false

    begin
      @wait.until { @driver.find_element(:xpath, "//td[text()='#{data}']") }
      found_data = true
    rescue
      found_data = false
    end

    return found_data
  end
end
