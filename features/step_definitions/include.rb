require 'json'

Given("create valid data to include API") do
  header = {
    "Authorization" => ENV['AUTHORIZATION_INCLUDE_API'],
    "Content-Type" => "application/json"
  }

  body = IncludeJson.get_body_new_order_id

  @options = {
   headers: header,
   body: body
  }
end

When("send data to include") do
  sp_api = SPApi.new
  @response_body = sp_api.post_payment_request_include(@options)
end

Then("system return sucess message and purchase link") do
  response_message = @response_body.parsed_response['Message']
  response_code = @response_body.parsed_response['Code']
  response_url_complete = @response_body.parsed_response['UrlCompleteOrder']

  Validator.check(response_message, "Solicitação enviada com sucesso. Estamos aguardando o cliente finalizar a compra!", "Mensagem diferente da esperada")
  Validator.check(response_code.to_s, "11200", "Codigo diferente do esperado")
  p "URL: #{response_url_complete}"
end
