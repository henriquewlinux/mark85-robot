*** Settings ***
Documentation       Ações e elementos da página de cadastro de tarefas

Library             Browser


*** Keywords ***
Submit task form
    [Arguments]    ${task}
    ${tags_element}    Set Variable    css=input[name=tags]

    Fill Text    css=input[name=name]    ${task}[name]

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text    ${tags_element}    ${tag}
        Press Keys    ${tags_element}    Enter
    END

    Click    css=button >> text=Cadastrar
