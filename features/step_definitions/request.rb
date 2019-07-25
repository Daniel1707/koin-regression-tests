require 'json'

AppEnvironment.get_environment_variables

Given("create valid data to request API") do
  header = {
    "Authorization" => ENV['AUTHORIZATION_REQUEST_API'],
    "Content-Type" => "application/json"
  }

  @body = Request.get_body_new_reference

  @options = {
   headers: header,
   body: @body
  }
end

When("send data to request") do
  sp_api = SPApi.new
  @response_body = sp_api.post_transaction_service_request(@options)
end

Then("system return success message") do
  response_message = @response_body.parsed_response['Message']
  response_code = @response_body.parsed_response['Code']

  Validator.check(response_message, "Seu pedido foi recebido pela KOIN e encontra-se em análise. Por favor aguarde, pois em breve você receberá a atualização do status por e-mail.", "Mensagem diferente da esperada")
  Validator.check(response_code, "312", "Codigo diferente do esperado")
end
