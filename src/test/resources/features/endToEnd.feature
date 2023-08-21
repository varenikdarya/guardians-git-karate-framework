@Regression
Feature: End to end Test for Account creation

  Background: Setup Test and Create Account
    * def result = callonce read('generateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create account, add phone, address, car
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    #Calling Java class in feature file. this utility will create object from Java Class.
    * def generateData = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateData.getEmail()
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Steven",
      "lastName": "Brows",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "DIVORCED",
      "employmentStatus": "SDET",
      "dateOfBirth": "1992-02-15"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    Given path "/api/accounts/add-account-phone"
    * def createdAccountId = response.id
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    * def phoneNumberGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = phoneNumberGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "909",
      "phoneTime": "morning",
      "phoneType": "mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber ==  phoneNumber
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    And request
      """
      {
      "addressType": "home",
      "addressLine1": "1512 Farm Rd",
      "city": "Wesley Chapel",
      "state": "FL",
      "postalCode": "25445",
      "countryCode": "+1",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    And request
      """
      {
      "make": "Jeep",
      "model": "Grand Cherokee",
      "year": "2023",
      "licensePlate": "4520"
      }
      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    When method delete
    Then status 200
