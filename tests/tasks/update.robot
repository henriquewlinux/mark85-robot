*** Settings ***
Documentation       Cenário de testes de atualização de tarefas

Resource            ../../resources/base.resource
Library             Browser

Test Setup          Start Session
Test Teardown       Take Screenshot


*** Test Cases ***
Deve poder marcar uma tarefa como concluida
    ${data}    Get fixture    tasks    done

    Remove task from database    ${data}[user][email]    ${data}[task][name]

    Create a new task from API    ${data}

    Do login    ${data}[user]

    Mark task as completed    ${data}[task][name]

    Get task completed    ${data}[task][name]
