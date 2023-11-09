*** Settings ***
Documentation       Ações e elementos da página Login

Library             Browser


*** Keywords ***
Submit login form
    [Arguments]    ${user}

    Fill Text    css=#email    ${user}[email]
    Fill Text    css=#password    ${user}[password]

    # Click    xpath=//button[text()="Entrar"]
    Click    css=button >> text=Entrar
