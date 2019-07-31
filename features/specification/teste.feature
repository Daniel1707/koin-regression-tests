Feature: teste

Scenario: Order from include and approve in manual analyse
  Given create valid data to include API
  When send data to include
  When system return success message and purchase link
  Then open link to finish purchase
  When accept purchase in in cash
  Then system will finish purchase with sucessuful and status Pedido em análise
  When go to Aquarius and open order in manual analyse
  Then approve order with higher limit
  When navigate to the Conductor login page
  When login
  When go to list accounts and search account using cpf
  Then carnê is show
