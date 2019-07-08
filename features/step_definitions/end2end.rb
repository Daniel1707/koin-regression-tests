require 'json'

Given("we navigate to the lojista login page") do
  config_driver = ConfigDriver.new("chrome")
  @driver = config_driver.get_driver
  @wait = config_driver.get_wait

  @lojista_page = LojistaPage.new(@driver, @wait)
  @lojista_page.openPage
end

When(/^fill user (\d+) and password (\d+)$/) do |user, password|
  @lojista_page.login(user, password)
end

Then("system will show lojista home page") do
  name = ENV['LOJISTA_NAME'].dup
  found_name = @lojista_page.is_logged(name.force_encoding(Encoding::UTF_8))
  Validator.check(found_name, true, "Did not find user logged")
end

Then("system will show message that user or password are invalid") do
  found_login_error_message = @lojista_page.has_error_login_message
  Validator.check(found_login_error_message, false, "Message for wrong password was not show")
end

And("go to Solicitar Pagamentos") do
  @lojista_page.clickRequestPayment
end

And(/^fill solicitation with proposal (\d+), CPF (\d+), date (\d+) and value (\d+)$/) do |proposal, cpf, date, value|
  @lojista_page.fillPaymentSolicitation(proposal, cpf, date, value)
  @lojista_page.clickConsultAvailability
end

And("fill solicitation with new data") do
  @pedidoRandom = rand(10000000..99999999)
  @amount = "500000"
  @cpf = CPF.generate

  @lojista_page.fillPaymentSolicitation(@pedidoRandom, @cpf, "20112019", @amount)
  @lojista_page.clickConsultAvailability
  @lojista_page.clickIncludeSolicitation
end

And("fill data buyer with new data confirming solicitation") do
  @lojista_page.fillIncludeSolicitation("Teste", "Teste", "17/07/1991", "(99)99999-9999", "#{@pedidoRandom}@koin.com.br", "06122-100", "12")

  @lojista_page.clickHospedagem

  @lojista_page.fillHospedagem("Teste Hospede", "20112019", "25112019", "Teste", "Teste")
  @lojista_page.clickAddGuest

  @lojista_page.fillOrderData(@pedidoRandom, "20112019", "1200", @amount)
  @lojista_page.clickRequestPaymentSolicitation
  @lojista_page.clickConfirmSolicitation
end

And("we navigate to the Aquarius login page") do
  @aquarius_page = AquariusPage.new(@driver, @wait)
  @aquarius_page.openPage
end

And("login with valid user in Aquarius") do
  @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])
end

And("get email confirmation from Aquarius") do
  @aquarius_page.click_on_comunication_log
  @aquarius_page.fill_comunication_log(@cpf)
  @aquarius_page.click_on_send_date
  p "PHONE: #{@aquarius_page.get_part_link_from_phone}"
end

And("go to Manual Analyse") do
  @aquarius_page.clickOnManualAnalyse
end
