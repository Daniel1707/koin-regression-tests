require 'json'

AppEnvironment.get_environment_variables

Given("create valid data to authorization API") do
  header = {
    "Authorization" => ENV['AUTHORIZATION_REQUEST_API'],
    "Content-Type" => "application/json"
  }

  @body = AuthorizationJson.get_body

  @options = {
   headers: header,
   body: @body
  }
end

When("send data to authorization") do
  sp_api = SPApi.new
  @response_body = sp_api.post_transaction_authorization(@options)
end

Then("system return success message for authorization") do
  response_message = @response_body.parsed_response['Message']
  Validator.check(response_message, "Autorizado", "Mensagem diferente da esperada")

  response_code = @response_body.parsed_response['Code']
  Validator.check(response_code, "12200", "Code diferente do esperado")
end

Given("connect to database") do
  p MysqlConnection.connect
end
