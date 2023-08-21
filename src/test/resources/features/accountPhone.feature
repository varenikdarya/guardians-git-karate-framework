@Regression
Feature: Create Account and Add Phone Number

  Background: Setup Test and Create Account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('createAccount.feature')
    And print createAccountResult
    * def validToken = createAccountResult.validToken
    * def createdAccountId = createAccountResult.response.id

  Scenario: Adding Phone number to an Account
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "",
      "phoneTime": "Evening",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And assert response.phoneNumber == phoneNumber