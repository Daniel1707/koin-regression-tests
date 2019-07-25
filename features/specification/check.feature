Feature: Check API

Scenario: Create check
  Given create valid data to check API
  When send data to check
  Then system return success message for check
