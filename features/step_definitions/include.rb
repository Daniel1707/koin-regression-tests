require 'json'

Given("create data valid to include API") do
  header = {
    "Authorization" => "8F6EC0BCB5634511A01B67785054E19E,VbH1VC/EjkeSuehEjetcjjdAMRCC/vBtDL8Z980isx2PUkLr2EHOrpkNRhydjsFy90JZZb59t5mcK2CNBYNhnA==,1560797432477",
    "Content-Type" => "application/json"
  }

  @options = {
   headers: header,
   body: IncludeJson.get_body
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
end
