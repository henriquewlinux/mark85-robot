*** Settings ***
Library     libs/database.py
Library     Browser
Library     JSONLibrary
Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Alerts.resource
Resource    pages/components/Header.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TaskPage.resource
Resource    services.resource


*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False
    New Page    ${BASE_URL}

# Helpers

Get fixture
    [Arguments]    ${filename}    ${scenario}

    ${data}    Load JSON From File
    ...    ${EXECDIR}/resources/fixtures/${filename}.json
    ...    encoding=UTF-8
    RETURN    ${data}[${scenario}]

Create a new task from API
    [Arguments]    ${data}

    POST user session    ${data}[user]
    POST a new task    ${data}[task]

Do login
    [Arguments]    ${user}

    Submit login form    ${user}
    User should be logged in    ${user}[name]
