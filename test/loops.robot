*** Settings ***
Documentation    This file contains test cases for the login functionality.
Library          SeleniumLibrary

*** Variables ***
@{list}    item1    item2    item3

*** Test Cases ***
Example Test
    FOR    ${item}    IN    @{list}
        Log    ${item}
        # Perform other actions on ${item}
    END
