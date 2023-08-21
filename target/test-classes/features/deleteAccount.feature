@Regression
Feature: Delete accounte

  Background: Setup test and generate token.
    * def createAccount = callonce read('createAccount.feature')
    * def validId = createAccount.response.id
    * def validToken = createAccount.validToken
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Delete the created account with existing ID
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = validId
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"

  Scenario: Delete the created account with not existing ID
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = validId
    Then method delete
    And status 404
    Then print response
    And assert response.errorMessage == "Account with id " + validId + " not exist"
