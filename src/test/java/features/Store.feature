@store @api
Feature: Verify STORE endpoint

  Background:
    Given I reset API parameters
    And I use "https://petstore.swagger.io/v2" as base URI

  @store1
  Scenario: Verify PetStoreOrders functionality of Store API
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    When I make "GET" call to "store/inventory"
    Then I get response code "200"
    And I verify PetStoreOrders details is available in the response


#BUG : SOMETIMES, DELETING THE DELETED ORDER DETAILS, RETURNS 200 INSTEAD OF 404. 
#SERVER TAKING LONG TO UPDATE THE RECORDS
  @store2
  Scenario: Verify order placed for purchasing the pet and then delete
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    Given I read request body from "addNewStoreRequest"
    When I make "POST" call to "/store/order"
    Then I get response code "200"
    And I verify ResposeBody for Status as "approved"
    And I capture the ID from response
    And I make "DELETE" call to "/store/order"
    And I get response code "200"
    And I make "DELETE" call to "/store/order"
    And I get response code "404"
    And I verify ResposeBody for message as "Order Not Found"


  @store3
  #BUG ==> THIS SCENARIO SHOULD GET FAILED BUT STILL GETTING PASSED EVEN IF EMPTY REQUEST BODY SENT.
  Scenario: I do POST request to store API without request body
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    And I make "POST" call to "/store/order"
    Then I get response code "400"
    And I verify ResposeBody for message as "bad request"
    
  @store4
  Scenario Outline: Verify place order for pet and then find order by ID
    Given I make REST service headers with the below fields
      | Content-Type     | Accept           |
      | application/json | application/json |
    Given I read request body from "addNewStoreRequest"
    And I update request with below values
      | id    | 
      | <ID> |
    When I make "POST" call to "/store/order"
    Then I get response code "200"    
    When I make "GET" call to "store/order/<ID>"
    Then I get response code "200"
    Then I verify ResposeBody for Status as "approved"
    Examples:
	  | ID 	    | 
      | 2131754 | 
      
  @store5
  Scenario Outline: Verify find purchase order with wrong ID returns negative result
    Given I make REST service headers with the below fields
      | Content-Type     | 
      | application/json | 
    When I make "GET" call to "store/order/<ID>"
    Then I get response code "404"
    And I verify ResposeBody for message as "Order not found"
    Examples:
	  | ID 	    | 
      | 1117965 | 
  

