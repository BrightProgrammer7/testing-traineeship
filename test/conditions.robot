*** Settings ***
Documentation    This file contains test cases for the login functionality.
Library          SeleniumLibrary

*** Variables ***
@{list}    1    2    3    4    5

*** Test Cases ***
Example Test
    FOR    ${item}    IN    @{list}
        Run Keyword If    ${item} % 2 == 0    Log    ${item} is even    ELSE    Log    ${item} is odd
    END
