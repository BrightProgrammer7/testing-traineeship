*** Settings ***
Documentation    This file contains test cases for the login functionality.
Library          SeleniumLibrary

*** Variables ***
@{list}    1    2    3    4    5

*** Test Cases ***
Example Test
    FOR    ${item}    IN    @{list}
        Check Number Type    ${item}
    END

*** Keywords ***
Check Number Type
    [Arguments]    ${number}
    Run Keyword If    ${number} % 2 == 0    Log    ${number} is even    ELSE    Log    ${number} is odd
