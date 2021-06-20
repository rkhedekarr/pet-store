@user @api
Feature: Verify USER endpoint

  Background:
    Given I use "https://petstore.swagger.io/v2" as base URI

  @user1
  Scenario Outline: Verify user is created, modified and then deleted using API calls
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    Given I read request body from "addNewUserRequest"
    And I update request with below values
      | username    |
      | <USER-NAME> |
    When I make "POST" call to "/user"
    Then I get response code "200"
    When I make "GET" call to "/user/<USER-NAME>"
    Then I get response code "200"
    And I make "DELETE" call to "/user/<USER-NAME>"
    And I get response code "200"
    And I make "DELETE" call to "/user/<USER-NAME>"
    And I get response code "404"
    Examples:
      | USER-NAME        |
      | RkhedekarrRahul1 |





