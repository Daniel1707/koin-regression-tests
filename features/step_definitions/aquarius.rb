require 'json'

AppEnvironment.get_environment_variables

Then("open link to finish purchase") do
  begin
    config_driver = ConfigDriver.new("chrome")
    @driver = config_driver.get_driver
    @wait = config_driver.get_wait

    @checkout_page = CheckoutPage.new(@driver, @wait)
    @checkout_page.open_page(@response_url_complete)
  rescue Exception => e
    Screenshot.take("open link to finish purchase", @driver)
    raise e
  end
end

When("accept purchase in in cash") do
  begin
    sleep 1
    @checkout_page.fill_birthdate("10071991")
    # @checkout_page.click_on_in_cash
    @checkout_page.click_on_accept_terms
    @checkout_page.click_on_finish_purchase
  rescue Exception => e
    Screenshot.take("accept purchase in in cash", @driver)
    raise e
  end
end

When("accept purchase in in cash without fill data") do
  begin
    @checkout_page.click_on_in_cash
    @checkout_page.click_on_accept_terms
    @checkout_page.click_on_finish_purchase
  rescue Exception => e
    Screenshot.take("accept purchase in in cash without fill data", @driver)
    raise e
  end
end

Then(/^system will finish purchase with sucessuful and status ([^"]*)$/) do |status|
  begin
    sleep 8
    found_message = @checkout_page.has_status_message(status.force_encoding(Encoding::UTF_8))
    Validator.check(found_message, true, "Did not find message #{status}")
  rescue Exception => e
    Screenshot.take("system will finish purchase with sucessuful and status #{status}", @driver)
    raise e
  end
end

When("go to Aquarius and open order in manual analyse") do
  begin
    @aquarius_page = AquariusPage.new(@driver, @wait)
    @aquarius_page.open_page
    @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])

    @aquarius_page.clickOnManualAnalyse
    @aquarius_page.fill_manual_analyse_filter_order(IncludeJson.get_order_id)
    @aquarius_page.click_on_start_manual_analyse
  rescue Exception => e
    Screenshot.take("go to Aquarius and open order in manual analyse", @driver)
    raise e
  end
end

When("go to Aquarius and open order in manual analyse using CPF") do
  begin
    config_driver = ConfigDriver.new("chrome")
    @driver = config_driver.get_driver
    @wait = config_driver.get_wait

    @aquarius_page = AquariusPage.new(@driver, @wait)
    @aquarius_page.open_page
    @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])

    @aquarius_page.clickOnManualAnalyse
    @aquarius_page.fill_manual_analyse_filter_order(ENV['CPF'])
    @aquarius_page.click_on_start_manual_analyse
  rescue Exception => e
    Screenshot.take("go to Aquarius and open order in manual analyse using CPF", @driver)
    raise e
  end
end

When("go to Aquarius and search order in manual analyse using CPF") do
  begin
    config_driver = ConfigDriver.new("chrome")
    @driver = config_driver.get_driver
    @wait = config_driver.get_wait

    @aquarius_page = AquariusPage.new(@driver, @wait)
    @aquarius_page.open_page
    @aquarius_page.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])

    @aquarius_page.clickOnManualAnalyse
    @aquarius_page.fill_manual_analyse_filter_order(ENV['CPF'])
  rescue Exception => e
    Screenshot.take("go to Aquarius and search order in manual analyse using CPF", @driver)
    raise e
  end
end

Then("order will be expired by scheduler") do
  sleep 140
  begin
    @aquarius_page.select_status_from_manual_analyse("Finalizado")
    @aquarius_page.click_on_consult
    sleep 5

    name = "expiration_job"
    decision = "Cancelado"

    user_name = @aquarius_page.get_result_manual_analyse_data(name)
    user_decision = @aquarius_page.get_result_manual_analyse_data(decision)

    Validator.check(user_name, true, "Did not find USER.")
    Validator.check(user_decision, true, "Did not find DECISION.")
  rescue Exception => e
    Screenshot.take("order will be expired by scheduler", @driver)
    raise e
  end
end

Then("fields from data client are correct") do
  begin
    status = @aquarius_page.get_manual_analyse_text_field("Status do Cliente")
    Validator.check(status, "P_NOVO", "Did not find.")

    cpf = @aquarius_page.get_manual_analyse_text_field("CPF")
    Validator.check(cpf, IncludeJson.get_cpf_formatted, "Did not find.")

    nome = @aquarius_page.get_manual_analyse_text_field("Nome Completo")
    Validator.check(nome, "Postman - API Include", "Did not find.")
  rescue Exception => e
    Screenshot.take("fields from data client are correct", @driver)
    raise e
  end
end

Then("fields from address are correct") do
  begin
    logradouro = @aquarius_page.get_manual_analyse_text_field("Logradouro")
    Validator.check(logradouro, "Rua Rio de Janeiro 909", "Did not find.")

    bairro = @aquarius_page.get_manual_analyse_text_field("Bairro")
    Validator.check(bairro, "Centro", "Did not find.")

    city = @aquarius_page.get_manual_analyse_text_field("Cidade(UF)")
    Validator.check(city, "Belo Horizonte - RJ", "Did not find.")

    cep = @aquarius_page.get_manual_analyse_text_field("CEP")
    Validator.check(cep, "30160-913", "Did not find.")
  rescue Exception => e
    Screenshot.take("fields from address are correct", @driver)
    raise e
  end
end

Then("fields from data purchase are correct") do
  begin
    store_name = @aquarius_page.get_manual_analyse_text_field("Nome da Loja")
    Validator.check(store_name, "Decolar", "Did not find.")

    description = @aquarius_page.get_manual_analyse_text_field("Descrição")
    Validator.check(description, "Pacote_hotel", "Did not find.")

    passengers_name = @aquarius_page.get_manual_analyse_text_field("Nome dos Passageiros")
    Validator.check(passengers_name, "1 - Nome Completo do Passageiro 1", "Did not find.")
  rescue Exception => e
    Screenshot.take("fields from data purchase are correct", @driver)
    raise e
  end
end

Then("approve order with higher limit") do
  sleep 1
  begin
    @aquarius_page.click_on_approve
    @aquarius_page.fill_limit("1000000")
    @aquarius_page.fill_observation("Teste")
    @aquarius_page.click_on_confirm
    @aquarius_page.logout
  rescue Exception => e
    Screenshot.take("approve order with higher limit", @driver)
    raise e
  end
end

Then(/^disapprove order for reason ([^"]*)$/) do |reason|
  begin
    @aquarius_page.click_on_disapprove
    @aquarius_page.select_reason(reason)
    @aquarius_page.fill_observation("Teste")
    @aquarius_page.click_on_confirm
    @aquarius_page.logout
  rescue Exception => e
    Screenshot.take("disapprove order for reason #{reason}", @driver)
    raise e
  end
end

Then("cancel order") do
  begin
    @aquarius_page.click_on_cancel
    @aquarius_page.fill_observation("Teste")
    @aquarius_page.click_on_confirm
    @aquarius_page.logout
  rescue Exception => e
    Screenshot.take("cancel order", @driver)
    raise e
  end
end
