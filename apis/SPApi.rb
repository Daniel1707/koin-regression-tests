require 'httparty'

class SPApi
  include HTTParty

  base_uri 'http://hmg-risks-sp-api.koin.com.br'

  def post_payment_request_include(options)
    self.class.post("/PaymentRequest/include", options)
  end

  def post_transaction_service_request(options)
    self.class.post("/V1/TransactionService.svc/Request", options)
  end

  def post_payment_request_check(options)
    self.class.post("/PaymentRequest/check", options)
  end

  def post_transaction_authorization(options)
    self.class.post("/Transaction/authorization", options)
  end
end
