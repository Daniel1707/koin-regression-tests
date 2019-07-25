require 'json'
require 'cpf_cnpj'

class AuthorizationJson

  @request_body = '{
   "Cpf":"561.736.264-03",
   "Email":"TESTE12dsfsdf3d@koin.com",
   "TotalPrice":"1000.00",
   "UseDate":"2020-12-20",
   "Ip":"123.456.789.012",
   "Optin": "true",
   "MaxInstallments":"",
   "FixInstallments":"",
   "SalesChannelId": "9"
}'

  def self.get_body
    return @request_body
  end
end
