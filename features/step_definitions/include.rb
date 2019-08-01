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

Given("create valid data to include API using CPF disapproved automatic") do
  header = {
    "Authorization" => ENV['AUTHORIZATION_INCLUDE_API'],
    "Content-Type" => "application/json"
  }

  @body = IncludeJson.get_body_cpf_disapproved_automatic

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
