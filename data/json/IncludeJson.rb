require 'json'
require 'cpf_cnpj'

class IncludeJson

  @include_body = '{
      "OrderID": "sadsda52344",
      "Proposal": "",
      "Currency": "BRL",
      "TotalPrice": "722.1",
      "Buyer": {
          "Name": "Postman - API Include",
          "Email": "teste@koin.com",
          "Documents": [
              {
                  "Type": "CPF",
                  "Number": ""
              }
          ],
          "Phones": [
              {
                  "AreaCode": "11",
                  "Number": "999398411"
              }
          ],
          "Address": {
              "ZipCode": "30160913",
              "Street": "Rua Rio de Janeiro 909",
              "Number": "909",
              "Complement": "",
              "City": "Belo Horizonte",
              "State": "MG",
              "Country": "Brasil",
              "Type": "1"
          }
      },
      "Shipping": {
          "UseDate": "2019-08-04",
          "Price": "0.00",
          "Address": null
      },
      "Items": [
          {
              "Reference": "101041441-1",
              "Description": "Origem no aeroporto GRU, com destino no aeroporto YYZ",
              "Quantity": "1",
              "Price": "722.1",
              "Category": "Passagem"
          }
      ],
      "AdditionalParameters": {
          "ExpirationDate": "2019-10-10 20:25:00",
          "SalesChannelId": "3"
      },
      "ProductType": [
          "Airline"
      ],
      "AdditionalData": {
          "AirlineData": {
              "Legs": [
                  {
                      "LegNumber": "1",
                      "Origin": "GRU",
                      "Destination": "YYZ",
                      "DepartureTime": "2020-08-04 21:40:00"
                  }
              ],
              "Passengers": [
                  {
                      "PassengerName": "ROSÂNGELA HUDSON JANUÁRIO"
                  }
              ]
          }
      }
  }'

  def self.get_body
    return JSON.parse(@include_body)
  end

  def self.get_body_new_order_id
    body_json = JSON.parse(@include_body)
    # @order_id = rand(10000000..99999999).to_s
    @cpf = CPF.generate

    body_json["OrderID"] = @cpf.to_s
    body_json["Buyer"]["Documents"][0]["Number"] = @cpf.to_s
    body_json["Buyer"]["Email"] = "#{@cpf.to_s}@koin.com.br"
    body = body_json.to_json

    return body
  end

  def self.get_order_id
    return @cpf.to_s
  end

  def self.get_cpf_formatted
    return CPF.new(@cpf).formatted
  end
end
