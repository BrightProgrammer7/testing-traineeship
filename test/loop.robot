*** Settings ***
Documentation    This file contains test cases for the login functionality.
Library          SeleniumLibrary

Suite Setup       Open browser     ${url}    ${browser}
Suite Teardown    Close browser

Test Setup        Double Click Element    //*[@id="jm"]/header

*** Variables ***
${url}         https://www.jumia.ma/
${browser}     chrome
@{emails}      fcaaisular784998@marketstore.pw    testuser@example.com    anotheruser@gmail.com
${password}    Test123@
${nom}         yas
${prenom}      yassine
${tel}         0708345678

*** Keywords ***
Search
    Click Element    //*[@id="jm"]/header/section/div[2]/div[1]/label
    Sleep            2s
    Click Element    //*[@id="dpdw-login-box"]/div/div/a
    Sleep            2s

Login
    [Arguments]     ${email}
    Input Text      //*[@id="input_identifierValue"]    ${email}
    Sleep           2s
    Click Element   //button[starts-with(@class,'mdc-button')]
    Sleep           2s
    Input Text      //input[starts-with(@class,'mdc-text')]    ${password}    
    Click Element   //button[starts-with(@class,'mdc-button')]
    Sleep           0.5s
    Capture Page Screenshot
    [Teardown]      # Teardown steps go here

Login with Invalid Credentials
    [Arguments]      ${email}
    Input Text       //*[@id="input_identifierValue"]    ${email}
    Sleep            2s
    Click Element    //button[starts-with(@class,'mdc-button')]
    Sleep            2s
    Input Text       //input[starts-with(@class,'mdc-text')]    mnnmnmn     
    Click Element    //button[starts-with(@class,'mdc-button')]
    Sleep            0.5s
    Wait Until Page Contains    Mot de passe incorrect. Réessayez ou cliquez sur "Mot de passe oublié?" pour le réinitialiser. 
    Capture Page Screenshot
    [Teardown]       # Teardown steps go here

Check for Error Message
    Wait Until Page Contains    Mot de passe incorrect. Réessayez ou cliquez sur "Mot de passe oublié?" pour le réinitialiser. 
    ${contains_error}    Run Keyword And Return Status    Wait Until Page Contains    Mot de passe incorrect. Réessayez ou cliquez sur "Mot de passe oublié?" pour le réinitialiser. 
    [Return]    ${contains_error}

Test Teardown
    Capture Page Screenshot

*** Test Cases ***
Login with Multiple Emails
    [Tags]    Login
    Search
    FOR    ${email}    IN    @{emails}
        Login    ${email}
        ${error}    Check for Error Message
        Run Keyword If    ${error}    Exit For Loop
    END
    Test Teardown
