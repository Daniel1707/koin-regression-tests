require 'json'

AppEnvironment.get_environment_variables

Given("create valid data to check API") do
  header = {
    "Authorization" => ENV['AUTHORIZATION_REQUEST_API'],
    "Content-Type" => "application/json"
  }

  @body = Check.get_body

  @options = {
   headers: header,
   body: @body
  }
end

When("send data to check") do
  sp_api = SPApi.new
  @response_body = sp_api.post_payment_request_check(@options)
end

Then("system return success message for check") do
  response_message = @response_body.parsed_response['Message']
  Validator.check(response_message, "Solicitação autorizada!", "Mensagem diferente da esperada")

  request_cpf = JSON.parse(@body)['CPF']
  response_cpf = @response_body.parsed_response['CPF']
  Validator.check(response_cpf, request_cpf, "CPF diferente do esperado")

  request_total_price = JSON.parse(@body)['TotalPrice']
  response_total_price = @response_body.parsed_response['TotalPrice']
  Validator.check(response_total_price, request_total_price, "TotalPrice diferente do esperado")

  request_proposal = JSON.parse(@body)['Proposal']
  response_proposal = @response_body.parsed_response['Proposal']
  Validator.check(response_proposal, request_proposal, "Proposal diferente do esperado")

  response_status = @response_body.parsed_response['status']
  Validator.check(response_status, "Aprovado", "Status diferente do esperada")
end
