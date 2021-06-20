# SwaggerPetStore
SwaggerPetStore API Automation project

## How to run the tests locally
The tests can be run locally using below command in terminal
```java
mvn test -Dcucumber.options="--tags @api"
```
There are 3 features available with tags @pet, @user and @store respectively. By changing the tag in above command we can control the execution.
E.g. If user wants to execute only Pets and User features then use below command.
```java
mvn test -Dcucumber.options="--tags @pet,@user"
```
The reports of the execution are available in 2 formats,
* cucumber --> Available at *target/Cucumber.json*
* html --> Available at *target/cucumber-reports/Cucumber.html*


## How to run the test in a CI/CD pipeline
_jenkins.pipeline_ file is available in the project. This file can be used for executing the tests using Jenkins.
There are 3 stages available in this file.
* Git pull --> *To pull the project from github*
* ExecuteTests --> *To exeucte the tests*
* upload --> *To upload the report(Cucumber.json) to Calliope.pro*

Note: This is a draft feature.

## Link to the results in Calliope.pro
Calliope reports can be found @ https://app.calliope.pro/companies/931/reports.
Viewing reports is currently restricted to other users.
