Feature: SP-API - Include

Scenario: Valid Include
  Given create valid data to include API
  When send data to include
  When system return success message and purchase link
  Then open link to finish purchase
  Then accept purchase in in cash
  Then system will finish purchase with sucessuful and status Pedido em análise
  Then go to Aquarius and open order in manual analyse
