require 'json'

class IncludeJson

  @include_body = '{
      "OrderID": "retretret",
      "Proposal": "",
      "Currency": "BRL",
      "TotalPrice": "722.1",
      "Buyer": {
          "Name": "Postman - API Include",
          "Email": "teste@koin.com",
          "Documents": [
              {
                  "Type": "CPF",
                  "Number": "40490198848"
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
    return @include_body
  end
end
