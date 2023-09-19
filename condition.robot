*** Settings ***
Documentation    This file contains test cases for the login functionality.
Library          SeleniumLibrary
Resource         variables.robot

Suite Setup       Open browser     ${url}    ${browser}
Suite Teardown    Close browser

Test Setup    Double Click Element    //*[@id="jm"]/header

*** Keywords ***
Search
    Click Element    //*[@id="jm"]/header/section/div[2]/div[1]/label
    Sleep            2s
    Click Element    //*[@id="dpdw-login-box"]/div/div/a
    Sleep            2s

Login
    Input Text                 //*[@id="input_identifierValue"]              ${email}
    Sleep                      2s
    Click Element              //button[starts-with(@class,'mdc-button')]
    Sleep                      2s
    Input Text                 //input[starts-with(@class,'mdc-text')]       ${password}    
    Click Element              //button[starts-with(@class,'mdc-button')]
    Sleep                      0.5s
    Run Keyword If            Page Should Not Contain Element            //div[contains(text(),'Mot de passe incorrect.')]
    ...                       Capture Page Screenshot
    ...                       ELSE
    ...                       Fail    "Login failed with invalid credentials."
    [Teardown]                 # Teardown steps go here


Login with Invalid Credentials
    [Arguments]    ${email}
    Input Text                  //*[@id="input_identifierValue"]                                                                   ${email}
    Sleep                       2s
    Click Element               //button[starts-with(@class,'mdc-button')]
    Sleep                       2s
    Input Text                  //input[starts-with(@class,'mdc-text')]                                                            mnnmnmn     
    Click Element               //button[starts-with(@class,'mdc-button')]
    Sleep                       0.5s
    Wait Until Page Contains    Mot de passe incorrect. Réessayez ou cliquez sur "Mot de passe oublié?" pour le réinitialiser. 
    Capture Page Screenshot
    [Teardown]                  # Teardown steps go here

Test Teardown
    Capture Page Screenshot

*** Test Cases ***
First Test
    [Tags]    Login
    Search
    Login    ${email}    ${password}
    Login with Invalid Credentials    ${email}
    Test Teardown
