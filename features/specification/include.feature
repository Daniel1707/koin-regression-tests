Feature: SP-API - Include

Scenario: Valid Include
  Given create data valid to include API
  When send data to include
  Then system return sucess message and purchase link
