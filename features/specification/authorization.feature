Feature: Authorization API

Scenario: Create authorization
  Given create valid data to authorization API
  When send data to authorization
  Then system return success message for authorization
