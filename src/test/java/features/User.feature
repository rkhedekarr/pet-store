@user @api
Feature: Verify USER endpoint

  Background:
    Given I use "https://petstore.swagger.io/v2" as base URI

  @user1
  Scenario Outline: Verify user is created, verified and then deleted using API calls
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
      
  @user2
  Scenario Outline: Verify user is created and then updated using API calls
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    Given I read request body from "addNewUserRequest"
    And I update request with below values
      | username    | password  |
      | <USER-NAME> |<PASSWORD>|
    When I make "POST" call to "/user"
    Then I get response code "200"
    And I read request body from "updateUserRequest"
    And I update request with below values
      | username        | password  |
      | <USER-NEW-NAME> | <NEW-PASSWORD>|
    When I make "PUT" call to "/user/<USER-NEW-NAME>"
    Then I get response code "200"    
    Examples:
	  | USER-NAME 	   | USER-NEW-NAME  | PASSWORD  | NEW-PASSWORD |
      | rkhedekarrRah  | RohanRkhedekarr| pass123   | pass321      |
      
      
  @user3
  Scenario Outline: Verify user is created, login, and then logout using API calls
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    Given I read request body from "addNewUserRequest"
    And I update request with below values
      | username    | password  |
      | <USER-NAME> |<PASSWORD>|
    When I make "POST" call to "/user"
    Then I get response code "200"
    When I make "GET" call to "/user/login?username=<USER-NAME>&password=<PASSWORD>"
    Then I get response code "200"  
 	When I make "GET" call to "/user/logout"
    Then I get response code "200"
    
    Examples:
	  | USER-NAME 	   | PASSWORD  |
      | rkhedekarrRah  | pass123   |   
      
      
  @user4
  Scenario Outline: Verify user is not created with invalid ID using API calls
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    Given I read request body from "addNewUserRequest"
    And I update request with below values
      | id   | 
      | <ID> |
    When I make "POST" call to "/user"
    Then I get response code "500"
    Examples:
    | <ID> |
    | test1234 |
      
