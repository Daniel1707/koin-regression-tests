Feature: Teste

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
