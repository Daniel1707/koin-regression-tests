require 'json'

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

Then("open link to finish purchase") do
  config_driver = ConfigDriver.new("chrome")
  @driver = config_driver.get_driver
  @wait = config_driver.get_wait

  @checkout_page = CheckoutPage.new(@driver, @wait)
  @checkout_page.openPage(@response_url_complete)
end

Then("accept purchase in in cash") do
  @checkout_page.fill_birthdate("10071991")
  @checkout_page.click_on_in_cash
  @checkout_page.click_on_accept_terms
  @checkout_page.click_on_finish_purchase
end

Then(/^system will finish purchase with sucessuful and status ([^"]*)$/) do |status|
  sleep 5
  found_message = @checkout_page.has_status_message(status.force_encoding(Encoding::UTF_8))
  Validator.check(found_message, true, "Did not find message #{status}")
end

Then("go to Aquarius and open order in manual analyse") do
  @aquarius_page = AquariusPage.new(@driver, @wait)
  @aquarius_page.openPage

  @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])

  @aquarius_page.clickOnManualAnalyse

  @aquarius_page.fill_manual_analyse_filter_order(IncludeJson.get_order_id)
  @aquarius_page.click_on_start_manual_analyse
  @aquarius_page.click_on_approve
  @aquarius_page.fill_limit("100000")
  @aquarius_page.fill_observation("Teste")
  @aquarius_page.click_on_confirm
end
