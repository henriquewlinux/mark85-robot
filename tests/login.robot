*** Settings ***
Documentation       Cenários de autenticação do usuários

Library             Collections
Resource            ../resources/base.resource

Test Setup          Start Session
Test Teardown       Take Screenshot


*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    ${user}    Create Dictionary
    ...    name=Henrique 2
    ...    email=henriquewlinux+1@gmail.com
    ...    password=qualidade

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login form    ${user}
    User should be logged in    ${user}[name]

Não deve logar com senha inválida
    ${user}    Create Dictionary
    ...    name=Usuario invalido
    ...    email=henriquewlinux+usuarioinvalido@gmail.com
    ...    password=qualidade

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=abc123

    Submit login form    ${user}
    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.
