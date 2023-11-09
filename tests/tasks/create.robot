*** Settings ***
Documentation       Cenários de cadastro de tarefas

Resource            ../../resources/base.resource

Test Setup          Start Session
Test Teardown       Take Screenshot


*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    ${data}    Get fixture    tasks    create

    Remove task from database    ${data}[user][email]    ${data}[task][name]

    Do login    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]
    Get task created    ${data}[task][name]

Do not should create duplicate task
    [Tags]    duplicate_task
    ${data}    Get fixture    tasks    duplicate

    Remove task from database    ${data}[user][email]    ${data}[task][name]

    Create a new task from API    ${data}

    Do login    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]

    Notice should be    Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de Tags
    [Tags]    tags_limit

    ${data}    Get fixture    tasks    tags_limit

    Remove task from database    ${data}[user][email]    ${data}[task][name]

    Do login    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]

    Notice should be    Oops! Limite de tags atingido.
