@pet @api
Feature: Verify PET endpoint

  Background:
    Given I use "https://petstore.swagger.io/v2" as base URI

  @pet1
  Scenario Outline: Verify findByStatus functionality of PET API
    When I make "GET" call to "/pet/findByStatus?status=<STATUS>"
    Then I get response code "200"
    And I verify at least "1" pet details is available in the response
    Examples:
      | STATUS    |
      | available |
      | pending   |
      | sold      |

  @pet2
  Scenario: Verify add new pet and delete added pet functionality of PET API
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    Given I read request body from "addNewPetRequest"
    When I make "POST" call to "/pet"
    Then I get response code "200"
    And I capture the ID from response
    And I make "DELETE" call to "/pet"
    And I get response code "200"
    And I make "DELETE" call to "/pet"
    And I get response code "404"

  @pet3
  Scenario: Verify findByStatus functionality of PET API with incorrect status
    When I make "GET" call to "/pet/findByStatus?status=Bought"
    Then I get response code "200"
    And I verify "0" pet details is available in the response

  @pet4
  Scenario Outline: Verify add and modify pet functionality of PET API
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    When I read request body from "addNewPetRequest"
    And I update request with below values
      | name       |
      | <PET-NAME> |
    Then I make "POST" call to "/pet"
    And I get response code "200"
    And I read request body from "updatePetRequest"
    And I update request with below values
      | name           |
      | <PET-NEW-NAME> |
    When I make "PUT" call to "/pet"
    Then I get response code "200"
    And I verify below values in response
      | name           |
      | <PET-NEW-NAME> |

    Examples:
      | PET-NAME | PET-NEW-NAME |
      | CAT      | TIGER        |
      
      
  @pet5
  Scenario Outline: Verify add pet image functionality
    Given I make REST service headers with the below fields
      | Content-Type        | Accept           |
      | multipart/form-data | application/json |
    Then I make POST call to "/pet/<PET-ID>/uploadImage" to upload pet image "cat.jpg"
    Then I get response code "200"
    Examples:
      | PET-ID |
      | 123    |
      
  @pet6
  Scenario Outline: Verify add pet image functionality with invalid header
    Given I make REST service headers with the below fields
      | Content-Type        | Accept           |
      | multipart/form-data231 | application/json |
    Then I make POST call to "/pet/<PET-ID>/uploadImage" to upload pet image "cat.jpg"
    Then I get response code "415"
    Examples:
      | PET-ID |
      | 12332  |
