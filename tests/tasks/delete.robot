*** Settings ***
Documentation       Cenário de testes de remoção de tarefas

Resource            ../../resources/base.resource
Library             Browser

Test Setup          Start Session
Test Teardown       Take Screenshot


*** Test Cases ***
Deve poder apagar uma tarefa
    ${data}    Get fixture    tasks    delete

    Remove task from database    ${data}[user][email]    ${data}[task][name]

    Create a new task from API    ${data}

    Do login    ${data}[user]

    Delete task    ${data}[task][name]

    Task should not exist    ${data}[task][name]
