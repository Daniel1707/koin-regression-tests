require 'json'
require 'cpf_cnpj'

class Check

  @request_body = '{
  "UseDate":"2020-01-01",
  "CPF":"235.617.359-59",
  "TotalPrice":"500.00",
  "Proposal":"123123",
  "SalesChannelId": "3"
}'

  def self.get_body
    return @request_body
  end
end
