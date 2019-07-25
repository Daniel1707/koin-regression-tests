Feature: Request API

Scenario: Create request and cancel in manual analyse
  Given create valid data to request API
  When send data to request
  Then system return success message
