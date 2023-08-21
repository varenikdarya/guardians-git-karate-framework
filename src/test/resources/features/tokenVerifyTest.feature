@Smoke
Feature: Token Verify Feature

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify a valid token
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response == "true"

  Scenario: Validate a valid token and invalid username
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "supervisorrr"
    And param token = response.token
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  Scenario: Validate a invalid token and valid username
    Then path "/api/token/verify"
    And param username = "supervisor"
    And param token = "wrong_token"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
    

  