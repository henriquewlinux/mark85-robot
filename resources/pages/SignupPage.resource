*** Settings ***
Documentation       Elementos e ações da página de cadastro

Library             Browser
Resource            ../env.resource


*** Keywords ***
Go to signup page
    Go To    ${BASE_URL}/signup

    Wait For Elements State    xpath=//h1[text()="Faça seu cadastro"]    visible    5
    Get Text    css=h1    equal    Faça seu cadastro

Submit signup form
    [Arguments]    ${user}

    Fill Text    css=#name    ${user}[name]
    Fill Text    css=#email    ${user}[email]
    Fill Text    css=#password    ${user}[password]

    Click    css=#buttonSignup >> text=Cadastrar

