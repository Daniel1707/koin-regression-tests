Feature: Risk

Scenario: Invalid Password
  Given we navigate to the lojista login page
  When fill user 77754962000160 and password 000000
  Then system will show message that user or password are invalid

Scenario: Valid Login
  Given we navigate to the lojista login page
  When fill user 77754962000160 and password 123456
  Then system will show lojista home page

Scenario: Manual Analyse Approve
  Given we navigate to the lojista login page
  When fill user 77754962000160 and password 123456
  And go to Solicitar Pagamentos
  And fill solicitation with new data
  And fill data buyer with new data confirming solicitation
  And we navigate to the Aquarius login page
  And login with valid user in Aquarius
  And get email confirmation from Aquarius
