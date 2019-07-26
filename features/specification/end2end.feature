Feature: End2End

Scenario: Order from include and cancel in manual analyse
  Given create valid data to include API
  When send data to include
  When system return success message and purchase link
  Then open link to finish purchase
  When accept purchase in in cash
  Then system will finish purchase with sucessuful and status Pedido em análise
  When go to Aquarius and open order in manual analyse
  Then cancel order

Scenario: Order from request and cancel in manual analyse
  Given create valid data to request API
  When send data to request
  Then system return success message
  When go to Aquarius and open order in manual analyse using CPF
  Then cancel order

Scenario: Order from include and disapprove in manual analyse for reason Sem Contato
  Given create valid data to include API
  When send data to include
  When system return success message and purchase link
  Then open link to finish purchase
  When accept purchase in in cash
  Then system will finish purchase with sucessuful and status Pedido em análise
  When go to Aquarius and open order in manual analyse
  Then fields from data client are correct
  Then fields from address are correct
  Then fields from data purchase are correct
  Then disapprove order for reason Sem Contato

Scenario: Order from request and cancel by scheduler
  Given create data to expire in Request API
  When send data to request
  Then system return success message
  When go to Aquarius and search order in manual analyse using CPF
  Then order will be expired by scheduler










Scenario: Order from seller page and disapprove automatic
  Given we navigate to the lojista login page
  When fill user 77754962000160 and password 123456
  And go to Solicitar Pagamentos
  And fill solicitation with CPF 19223658071

Scenario: Order from include and approve in manual analyse
  Given create valid data to include API
  When send data to include
  When system return success message and purchase link
  Then open link to finish purchase
  When accept purchase in in cash
  Then system will finish purchase with sucessuful and status Pedido em análise
  When go to Aquarius and open order in manual analyse
  Then approve order with higher limit

Scenario: Manual Analyse Approve from seller page
  Given we navigate to the lojista login page
  When fill user 77754962000160 and password 123456
  And go to Solicitar Pagamentos
  And fill solicitation with new data
  And fill data buyer with new data confirming solicitation
  And we navigate to the Aquarius login page
  And login with valid user in Aquarius
  And get email confirmation from Aquarius
