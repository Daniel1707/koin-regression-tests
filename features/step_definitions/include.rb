require 'json'

AppEnvironment.get_environment_variables

Given("create valid data to include API") do
  header = {
    "Authorization" => ENV['AUTHORIZATION_INCLUDE_API'],
    "Content-Type" => "application/json"
  }

  @body = IncludeJson.get_body_new_order_id

  @options = {
   headers: header,
   body: @body
  }
end

Given("create valid data to include API using CPF approved automatic") do
  header = {
    "Authorization" => ENV['AUTHORIZATION_INCLUDE_API'],
    "Content-Type" => "application/json"
  }

  @body = IncludeJson.get_body_cpf_approved_automatic

  @options = {
   headers: header,
   body: @body
  }
end

When("send data to include") do
  sp_api = SPApi.new
  @response_body = sp_api.post_payment_request_include(@options)
end

When("system return success message and purchase link") do
  response_message = @response_body.parsed_response['Message']
  response_code = @response_body.parsed_response['Code']
  @response_url_complete = @response_body.parsed_response['UrlCompleteOrder']

  Validator.check(response_message, "Solicitação enviada com sucesso. Estamos aguardando o cliente finalizar a compra!", "Mensagem diferente da esperada")
  Validator.check(response_code.to_s, "11200", "Codigo diferente do esperado")
end

Then("system return message that buyer can not use koin") do
  response_message = @response_body.parsed_response['Message']
  response_code = @response_body.parsed_response['Code']

  Validator.check(response_message, "Infelizmente não será possível prosseguir com a solicitação! Sugerimos que utilize outra forma de pagamento.", "Mensagem diferente da esperada")
  Validator.check(response_code.to_s, "11300", "Codigo diferente do esperado")
end

Then("open link to finish purchase") do
  config_driver = ConfigDriver.new("chrome")
  @driver = config_driver.get_driver
  @wait = config_driver.get_wait

  @checkout_page = CheckoutPage.new(@driver, @wait)
  @checkout_page.openPage(@response_url_complete)
end

When("accept purchase in in cash") do
  @checkout_page.fill_birthdate("10071991")
  @checkout_page.click_on_in_cash
  @checkout_page.click_on_accept_terms
  @checkout_page.click_on_finish_purchase
end

Then(/^system will finish purchase with sucessuful and status ([^"]*)$/) do |status|
  sleep 6
  found_message = @checkout_page.has_status_message(status.force_encoding(Encoding::UTF_8))
  Validator.check(found_message, true, "Did not find message #{status}")
end

When("go to Aquarius and open order in manual analyse") do
  @aquarius_page = AquariusPage.new(@driver, @wait)
  @aquarius_page.openPage
  @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])

  @aquarius_page.clickOnManualAnalyse
  @aquarius_page.fill_manual_analyse_filter_order(IncludeJson.get_order_id)
  @aquarius_page.click_on_start_manual_analyse
end

When("go to Aquarius and open order in manual analyse using CPF") do
  config_driver = ConfigDriver.new("chrome")
  @driver = config_driver.get_driver
  @wait = config_driver.get_wait

  @aquarius_page = AquariusPage.new(@driver, @wait)
  @aquarius_page.openPage
  @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])

  @aquarius_page.clickOnManualAnalyse
  @aquarius_page.fill_manual_analyse_filter_order(ENV['CPF'])
  @aquarius_page.click_on_start_manual_analyse
end

When("go to Aquarius and search order in manual analyse using CPF") do
  config_driver = ConfigDriver.new("chrome")
  @driver = config_driver.get_driver
  @wait = config_driver.get_wait

  @aquarius_page = AquariusPage.new(@driver, @wait)
  @aquarius_page.openPage
  @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])

  @aquarius_page.clickOnManualAnalyse
  @aquarius_page.fill_manual_analyse_filter_order(ENV['CPF'])
end

Then("order will be expired by scheduler") do
  sleep 140
  @aquarius_page.select_status_from_manual_analyse("Finalizado")
  @aquarius_page.click_on_consult
  sleep 5

  name = "expiration_job"
  decision = "Cancelado"

  user_name = @aquarius_page.get_result_manual_analyse_data(name)
  user_decision = @aquarius_page.get_result_manual_analyse_data(decision)

  Validator.check(user_name, true, "Did not find USER.")
  Validator.check(user_decision, true, "Did not find DECISION.")
end

Then("fields from data client are correct") do
  status = @aquarius_page.get_manual_analyse_text_field("Status do Cliente")
  Validator.check(status, "P_NOVO", "Did not find.")

  cpf = @aquarius_page.get_manual_analyse_text_field("CPF")
  Validator.check(cpf, IncludeJson.get_cpf_formatted, "Did not find.")

  nome = @aquarius_page.get_manual_analyse_text_field("Nome Completo")
  Validator.check(nome, "Postman - API Include", "Did not find.")
end

Then("fields from address are correct") do
  logradouro = @aquarius_page.get_manual_analyse_text_field("Logradouro")
  Validator.check(logradouro, "Rua Rio de Janeiro 909", "Did not find.")

  bairro = @aquarius_page.get_manual_analyse_text_field("Bairro")
  Validator.check(bairro, "Centro", "Did not find.")

  city = @aquarius_page.get_manual_analyse_text_field("Cidade(UF)")
  Validator.check(city, "Belo Horizonte - MG", "Did not find.")

  cep = @aquarius_page.get_manual_analyse_text_field("CEP")
  Validator.check(cep, "30160-913", "Did not find.")
end

Then("fields from data purchase are correct") do
  store_name = @aquarius_page.get_manual_analyse_text_field("Nome da Loja")
  Validator.check(store_name, "Decolar", "Did not find.")

  installment_amount = @aquarius_page.get_manual_analyse_text_field("Valor da Parcela")
  Validator.check(installment_amount, "1x R$ 722,10", "Did not find.")

  total_amount = @aquarius_page.get_manual_analyse_text_field("Valor total")
  Validator.check(total_amount, "R$ 722,10", "Did not find.")

  description = @aquarius_page.get_manual_analyse_text_field("Descrição")
  Validator.check(description, "Origem no aeroporto GRU, com destino no aeroporto YYZ", "Did not find.")

  description = @aquarius_page.get_manual_analyse_text_field("Descrição")
  Validator.check(description, "Origem no aeroporto GRU, com destino no aeroporto YYZ", "Did not find.")

  passengers_name = @aquarius_page.get_manual_analyse_text_field("Nome dos Passageiros")
  Validator.check(passengers_name, "1 - ROSÂNGELA HUDSON JANUÁRIO", "Did not find.")
end

Then("approve order with higher limit") do
  sleep 1
  @aquarius_page.click_on_approve
  @aquarius_page.fill_limit("100000")
  @aquarius_page.fill_observation("Teste")
  @aquarius_page.click_on_confirm
  @aquarius_page.logout
end

Then(/^disapprove order for reason ([^"]*)$/) do |reason|
  @aquarius_page.click_on_disapprove
  @aquarius_page.select_reason(reason)
  @aquarius_page.fill_observation("Teste")
  @aquarius_page.click_on_confirm
  @aquarius_page.logout
end

Then("cancel order") do
  @aquarius_page.click_on_cancel
  @aquarius_page.fill_observation("Teste")
  @aquarius_page.click_on_confirm
  @aquarius_page.logout
end
