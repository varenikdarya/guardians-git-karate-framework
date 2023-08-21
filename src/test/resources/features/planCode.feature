@Regression
Feature: Plan Code feature

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenFeatureResult = callonce read('generateToken.feature')
    And print tokenFeatureResult
    * def validToken = tokenFeatureResult.response.token

  Scenario: Validated get plan codes
    And path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + validToken
    When method get
    Then status 200
    And print response
    And assert response[0].planExpired == false
    And assert response[1].planExpired == false
    And assert response[2].planExpired == false
    And assert response[3].planExpired == false
    
