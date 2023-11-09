*** Settings ***
Documentation       Cenários de testes do cadastro de usuários

# Library    FakerLibrary
Resource            ../resources/base.resource

# Suite Setup    Log    Tudo aqui ocorre antes da Suite(antes de todos os testes)
# Suite Teardown    Log    Tudo aqui ocorre antes da Suite(depois da todos os testes)
Test Setup          Start Session
Test Teardown       Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuários
    # ${name}    FakerLibrary.Name
    # ${email}    FakerLibrary.Free Email
    # ${password}    Set Variable    qualidade

    ${user}    Create Dictionary
    ...    name=Henrique 2
    ...    email=henriquewlinux+1@gmail.com
    ...    password=qualidade

    Remove user from database    ${user}[email]

    Go to signup page
    Submit signup form    ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    duplicidade

    ${user}    Create Dictionary
    ...    name=Henrique +2
    ...    email=henriquewlinux+2@gmail.com
    ...    password=qualidade

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup page
    Submit signup form    ${user}
    Notice should be    Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required

    ${user}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}

    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve realizar cadastro com email invalido
    [Tags]    invalid_mail
    ${user}    Create Dictionary
    ...    name=Henrique Silveira
    ...    email=henrique.com.br
    ...    password=qualidade

    Go to signup page
    Submit signup form    ${user}
    Alert should be    Digite um e-mail válido

Não deve realizar cadastro com senha < 6 digitos
    [Tags]    shortpass

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
        ${user}    Create Dictionary
        ...    name=Henrique +2
        ...    email=henriquewlinux+senha5digitos@gmail.com
        ...    password=${password}

        Go to signup page
        Submit signup form    ${user}
        Alert should be    Informe uma senha com pelo menos 6 digitos
    END
