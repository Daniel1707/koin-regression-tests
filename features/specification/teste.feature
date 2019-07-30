Feature: Teste

Scenario: Manual Analyse Approve from seller page
  Given we navigate to the lojista login page
  When fill user 77754962000160 and password 123456
  And go to Solicitar Pagamentos
  And fill solicitation with new data
  And fill data buyer with new data confirming solicitation
  And we navigate to the Aquarius login page
  And login with valid user in Aquarius
  And get email confirmation from Aquarius
