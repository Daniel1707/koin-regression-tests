require 'json'
require 'cpf_cnpj'

class IncludeJson

  @include_body = '{
  "IdPaymentRequest": "",
  "OrderID": "{{CPF}}",
  "Currency": "BRL",
  "TotalPrice": "1000.00",
  "Proposal": "",
  "DiscountValue": "00.00",
  "IncreaseValue": "00.00",
  "ProductType": [
    "Airline",
    "Lodging"
  ],
  "Buyer": {
    "Name": "Postman - API Include",
    "Email": "{{CPF}}@koin.com",
    "BirthDate": "",
    "BuyerStatus": "",
    "Documents": [
      {
        "Type": "CPF",
        "Number": "{{CPF}}"
      }
    ],
    "Phones": [
      {
        "AreaCode": "98",
        "Number": "92929-9292"
      }
    ],
    "Address": {
      "City": "Belo Horizonte",
      "State": "RJ",
      "Country": "Brasil",
      "District": "Centro",
      "Street": "Rua Rio de Janeiro 909",
      "Number": "804",
      "Complement": "",
      "ZipCode": "30160-913",
      "Type": "1"
    }
  },
  "Shipping": {
    "Address": {
      "City": "Feira de Santana",
      "State": "BA",
      "Country": "Brasil",
      "District": "Centro",
      "Street": "Rua Rio de Janeiro 909",
      "Number": "804",
      "Complement": "",
      "ZipCode": "44024-452",
      "Type": "1"
    },
    "Price": "00.00",
    "UseDate": "2020-10-30"
  },
  "Items": [
    {
      "Reference": "01234",
      "Category": "105050",
      "Description": "Pacote_hotel",
      "Quantity": "11",
      "Price": "100.00"
    }
  ],
  "AdditionalParameters": {
    "ExpirationDate": "2019-10-23 09:37:00",
    "UserExpirationDate": "2020-05-09 17:24:00",
    "IntermediateId": "01324567890132456789",
    "SalesChannelId": "3",
    "MaxInstallments": "0",
    "FixInstallments": "2"
  },
  "AdditionalData": {
    "AirlineData": {
      "Legs": [
        {
          "LegNumber": "1",
          "Origin": "CGH",
          "Destination": "REC",
          "FlightNumber": "1063",
          "DepartureTime": "2019-07-14 15:00:00",
          "StopOverAllowed": "Y",
          "IdClass": "F",
          "AirlineRefund": "N"
        }
      ],
      "Passengers": [
        {
          "PassengerName": "Nome Completo do Passageiro 1",
          "PassengerEmail": "passageiro1@dominio.com",
          "PassengerPhone": "552133665591",
          "PassengerBirthDate": "1958-12-22",
          "PassengerRating": "Adult",
          "PassengerStatus": "Gold",
          "PassengerNationality": "Brasil",
          "PassengerDocuments": [
            {
              "Type": "CPF",
              "Number": "396.469.778-80"
            }
          ]
        }
      ]
    },
    "LodgingData": {
      "LodgingName": "Pousada Porto Mar",
      "CheckInDate": "2019-04-05",
      "CheckOutDate": "2019-04-13",
      "Duration": "7",
      "LodgingRefund": "N",
      "LodgingAddress": {
        "ZipCode": "01311-300",
        "Street": "Av. Paulista",
        "Number": "1728",
        "Complement": "7 andar",
        "District": "Bela Vista",
        "City": "São Paulo",
        "State": "SP",
        "Country": "Brasil",
        "Type": "1"
      },
      "lodgers": [
        {
          "LodgerName": "TESTE DAVID CAIO",
          "LodgerEmail": "hospede@dominio.com",
          "LodgerPhone": "552133665591",
          "LodgerDocuments": [
            {
              "Type": "CPF",
              "Number": "396.469.778-80"
            }
          ]
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

    ENV['CPF'] = @cpf

    body_json["OrderID"] = @cpf.to_s
    body_json["Buyer"]["Documents"][0]["Number"] = @cpf.to_s
    body_json["Buyer"]["Email"] = "#{@cpf.to_s}@koin.com.br"
    body = body_json.to_json

    p "INCLUDE BODY #{body}"

    return body
  end

  def self.get_body_cpf_approved_automatic
    body_json = JSON.parse(@include_body)
    @order_id = rand(10000000..99999999).to_s
    @cpf = ENV["CPF_APPRROVED"]

    ENV['CPF'] = @cpf

    body_json["OrderID"] = @order_id
    body_json["Buyer"]["Documents"][0]["Number"] = @cpf.to_s
    body_json["Buyer"]["Email"] = "#{@cpf.to_s}@koin.com.br"
    body = body_json.to_json

    p "INCLUDE BODY #{body}"

    return body
  end

  def self.get_body_cpf_disapproved_automatic
    body_json = JSON.parse(@include_body)
    @order_id = rand(10000000..99999999).to_s
    @cpf = ENV["CPF_DISAPPRROVED"]

    ENV['CPF'] = @cpf

    body_json["OrderID"] = @order_id
    body_json["Buyer"]["Documents"][0]["Number"] = @cpf.to_s
    body_json["Buyer"]["Email"] = "#{@cpf.to_s}@koin.com.br"
    body = body_json.to_json

    p "INCLUDE BODY #{body}"

    return body
  end

  def self.get_order_id
    return @cpf.to_s
  end

  def self.get_cpf_formatted
    return CPF.new(@cpf).formatted
  end
end
