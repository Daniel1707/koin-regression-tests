require 'json'
require 'cpf_cnpj'
require 'date'

class Request

  @request_body = '{
  "FraudId":"9a6ce08d275bj4106396f2aa982fc2158254k",
  "MerchantIntegrationId":null,
  "Currency":"BRL",
  "Price":"1000",
  "Reference":"40490199999",
  "PaymentType":"21",
  "Buyer":{
     "Email":"40490199999@skoin.com.br",
     "Documents":[
        {
           "Key":"CPF",
           "Value":"40490199999"
        }
     ],
        "Address":{
        "Country":"BRA",
        "State":"SP",
        "City":"São Paulo",
        "District":"Jd, Matarazzo",
        "ZipCode":"03813310",
        "Street":"Rua, Japichaua",
        "Number":"100",
        "Complement":"Casa casa",
        "AddressType":1
     },
     "Phones":[
        {
           "AreaCode":"11",
           "Number":"999999999",
           "PhoneType":2
        }
     ],
     "Name":"Request 40490199999",
     "Ip":"127.0.0.1",
     "IsReliable":false,
     "IsFirstPurchase":false,
     "BuyerType":1,
     "AdditionalInfo":[
        {
           "Key":"Birthday",
           "Value":"1990-03-20"
        }
     ]
  },
  "DiscountPercent":0,
  "DiscountValue":0,
  "IncreasePercent":0,
  "IncreaseValue":0,
  "IsGift":false,
  "RequestDate":"2017-04-11 16:28:38",
  "Shipping":{
     "Address":{
        "Country":"BRA",
        "State":"SP",
        "City":"Sao Paulo",
        "District":"Jd Matarazzo",
        "ZipCode":"03813310",
        "Street":"Rua Japichaua",
        "Number":"100",
        "Complement":"Casa",
        "AddressType":1
     },
     "ShippingType":1,
     "ShippingProduct":null,
     "DeliveryDate":"2020-04-11",
     "Price":"00.00"
  },
  "Items":[
     {
        "Reference":"Cod_Item_46846",
        "Description":"Teste boleto registrado",
        "Category":"Teste",
        "Quantity":1,
        "Price":1000,
        "Attributes":[]
     }
  ],
  "AdditionalParameters":{
     "PartnerId":"001",
     "ExpirationDate":"2019-07-30 09:33:00",
     "SalesChannelId":"31"
     },
  "AdditionalData":{
     "AirlineData":{
        "Legs":[
           {
              "LegNumber":"1",
              "Origin":"CGH",
              "Destination":"REC",
              "FlightNumber":"1063",
              "DepartureTime":"2019-04-06 06:20:00",
              "StopOverAllowed":"Y",
              "IdClass":"F",
              "AirlineRefund":"N"
           }
        ],
        "Passengers":[
           {
              "PassengerName":"Nome Completo do Passageiro 1",
              "PassengerEmail":"caio.monteiro@koin.com.br",
              "PassengerPhone":"552133665591",
              "PassengerBirthDate":"1958-12-22",
              "PassengerRating":"Adult",
              "PassengerStatus":"Gold",
              "PassengerNationality":"Brasil",
              "PassengerDocuments":[
                 {
                    "Key":"CPF",
                    "Value":"396.469.778-80"
                 }
              ]
           }
        ]
     },
     "LodgingData":{
        "LodgingName":"Pousada Porto Mar",
        "CheckInDate":"2019-04-06",
        "CheckOutDate":"2019-04-13",
        "Duration":"7",
        "LodgingRefund":"N",
        "LodgingAddress":{
           "ZipCode":"01311-300",
           "Street":"Av. Paulista",
           "Number":"1728",
           "Complement":"7 andar",
           "District":"Bela Vista",
           "City":"São Paulo",
           "State":"SP",
           "Country":"Brasil",
           "Type":"1"
        },
        "Lodgers":[
           {
              "LodgerName":"Nome Completo do Passageiro 1",
              "LodgerEmail":"caio.montediro@koin.com.br",
              "LodgerPhone":"552133665591",
              "LodgerDocuments":[
                 {
                    "Key":"CPF",
                    "Value":"404.901.999-19"
                 }
              ]
           }
        ]
     }
  }
}'

  def self.get_body
    return JSON.parse(@request_body)
  end

  def self.get_body_new_reference
    body_json = JSON.parse(@request_body)

    # @reference = rand(10000000..99999999).to_s
    @cpf = CPF.generate.to_s
    body_json["Reference"] = @cpf
    body_json["Buyer"]["Email"] = "#{@cpf}@koin.com.br"
    body_json["Buyer"]["Documents"][0]["Value"] = @cpf
    body_json["Buyer"]["Name"] = "Teste #{@cpf}"

    body_json["AdditionalParameters"]["ExpirationDate"] = DateUtil.get_current_date_plus_minute(1)

    body = body_json.to_json

    ENV['CPF'] = @cpf

    return body
  end

  def self.get_reference
    return @cpf
  end
end
