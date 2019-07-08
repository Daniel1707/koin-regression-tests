require 'selenium-webdriver'

class LojistaPage

  def initialize(driver, wait)
    @driver = driver
    @wait = wait
  end

  def openPage
    @driver.get ENV['LOJISTA_ENV']
    @driver.manage.window.maximize
    sleep 1
  end

  def login(user, password)
    userField = @wait.until { @driver.find_element(:id, "login") }
    userField.send_keys(user)

    @driver.find_element(:id, "password").send_keys(password)
    @driver.find_element(:id, "login").submit
  end

  def is_logged(user)
    sleep 3

    user_logged = false

    begin
      user_logged = @driver.find_element(:xpath, "//h3[text()='#{user}']").displayed?
    rescue
    	user_logged = false
    end

    return user_logged
  end

  def has_error_login_message
    message_error = false

    begin
      message_error = @driver.find_element(:xpath, "//div[@id='entrarMessage']").displayed?
    rescue
    	message_error = false
    end

    return message_error
  end

  def clickRequestPayment
    requestPayment = @wait.until { @driver.find_element(:xpath, "//a[@href='/solicitarPagamento']") }
    requestPayment.click
  end

  def fillPaymentSolicitation(numberProposta, cpf, deliveryDate, price)
    numberField = @wait.until { @driver.find_element(:id, "numberProposta") }
    numberField.send_keys(numberProposta)

    @driver.find_element(:id, "cpf").send_keys(cpf)
    @driver.find_element(:id, "deliveryDate").send_keys(deliveryDate)
    @driver.find_element(:id, "price").send_keys(price)
  end

  def clickConsultAvailability
    consultAvailability = @wait.until { @driver.find_element(:xpath, '//button[text()="Consultar
                  Disponibilidade"]') }
    consultAvailability.click
  end

  def clickIncludeSolicitation
    includeSolicitation = @wait.until { @driver.find_element(:xpath, '//button[text()="Incluir
                  Solicitação"]') }
    includeSolicitation.click
  end

  def fillIncludeSolicitation(name, surname, birthDate, cellPhone, email, cep, number)
    orderName = @wait.until { @driver.find_element(:id, "nomePedido") }
    sleep 1
    orderName.send_keys(name)

    sleep 3
    @driver.find_element(:id, "sobrenomePedido").send_keys(surname)

    sleep 1
    @driver.find_element(:id, "birthdate").send_keys(birthDate)

    sleep 1
    @driver.find_element(:id, "telCelularPedido").send_keys(cellPhone)

    sleep 1
    @driver.find_element(:id, "emailPedido").send_keys(email)

    sleep 1
    @driver.find_element(:id, "cepPedido").send_keys(cep)

    sleep 1
    @driver.find_element(:id, "numCasaPedido").send_keys(number)
  end

  def clickHospedagem
    hospedagem = @wait.until { @driver.find_element(:xpath, '//button[text()="Hospedagem"]') }
    hospedagem.click
  end

  def fillHospedagem(nameHospedagemValue, checkInDate, checkOutDate, namePassenger, surnamePassenger)
    nameHospedagem = @wait.until { @driver.find_element(:id, "lodgingName") }
    nameHospedagem.send_keys(nameHospedagemValue)

    @driver.find_element(:id, "checkInDate").send_keys(checkInDate)
    @driver.find_element(:id, "checkOutDate").send_keys(checkOutDate)

    @driver.find_element(:id, "lodgerName").send_keys(namePassenger)
    @driver.find_element(:id, "lodgerLastName").send_keys(surnamePassenger)
  end

  def clickAddGuest
    hospedagem = @wait.until { @driver.find_element(:xpath, '//button[text()="Adicionar Hóspede"]') }
    hospedagem.click
  end

  def fillOrderData(orderNumberValue, expirationDateValue, hourExpirationValue, confirmTotalAmountValue)
    orderNumber = @wait.until { @driver.find_element(:id, "numeroPedido") }
    orderNumber.send_keys(orderNumberValue)

    @driver.find_element(:id, "dateExpire").send_keys(expirationDateValue)
    @driver.find_element(:id, "time").send_keys(hourExpirationValue)
    @driver.find_element(:id, "totalValue").send_keys(confirmTotalAmountValue)
  end

  def clickRequestPaymentSolicitation
    hospedagem = @wait.until { @driver.find_element(:xpath, '//button[text()="Solicitar Pagamento"]') }
    hospedagem.click
  end

  def clickConfirmSolicitation
    hospedagem = @wait.until { @driver.find_element(:xpath, '//button[text()="Confirmar Solicitação"]') }
    hospedagem.click
  end
end
