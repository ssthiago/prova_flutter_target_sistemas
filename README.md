# README

## Flutter Prova App

Este projeto é um aplicativo Flutter desenvolvido por mim, Thiago Sarmento Magalhães, como resposta ao desafio "Prova Flutter", que consiste em criar um aplicativo com telas de login e captura de informações, seguindo as diretrizes fornecidas.

### Estrutura do Projeto

A estrutura do projeto segue uma abordagem baseada em Clean Architecture, organizando os arquivos em diferentes camadas para facilitar a manutenção e escalabilidade do código. Abaixo está a hierarquia de pastas do projeto:


# Estrutura do Projeto

- **main.dart**

- **core**
    - app_constants.dart
    - strings_constants.dart
    - **services**
        - services.dart
    - **utils**
        - validate.dart

- **data**
    - **datasource**
        - **remote**
            - authentication_datasource_impl.dart
            - i_authentication_datasource.dart
        - **api**
            - i_client_api.dart
            - **dio**
                - dio_client_api.dart
                - dio_errors.dart
    - **repositories**
        - authentication_repository_impl.dart
    - **services**
        - **authenticated**
            - i_user_session_manager.dart
            - user_session_manager.dart
        - **information**
            - information_manager.dart
            - i_information_manager.dart

- **domain**
    - **entities**
        - information.dart
        - user.dart
        - user_session.dart
    - **repositories**
        - i_authentication_repository.dart
        - i_information_repository.dart
    - **result**
        - failure.dart
        - result.dart
        - success.dart
    - **usecases**
        - i_usecase.dart
        - i_usecase_no_params.dart
        - usecase_result.dart
        - **authentication**
            - **login**
                - login_usecase.dart
                - **result**
                    - login_failure.dart
                    - login_params.dart
                    - login_success.dart
            - **logout**
                - logout_usecase.dart
                - **result**
                    - logout_failure.dart
                    - logout_success.dart
        - **information**
            - **save_information**
                - save_information_usecase.dart
                - **result**
                    - save_information_failure.dart
                    - save_information_params.dart
                    - save_information_success.dart

- **presentation**
    - **common_widgets**
        - rounded_button.dart
    - **informations**
        - informations_page.dart
        - informations_store.dart
        - **local_widgets**
            - informations_fields.dart
    - **login**
        - login_page.dart
        - login_store.dart
        - **local_widgets**
            - login_fields.dart

- **routes**
    - app_routes.dart


### Clean Architecture (Layer First)

A escolha da Clean Architecture - layer first, com suas camadas distintas (domain, data, presentation), me permitiu uma separação clara das responsabilidades e facilidade de manutenção e testabilidade do código.

- **Domain**: Contém as entidades, repositórios e casos de uso (use cases) da aplicação. Aqui, definimos as regras de negócios e a lógica de aplicação.

- **Data**: Responsável pela implementação dos repositórios e fontes de dados. As implementações concretas das interfaces definidas no domínio estão localizadas aqui.

- **Presentation**: Lida com a camada de UI e a gestão de estado. Aqui, temos os widgets, stores (usando MobX), e a lógica de apresentação.

### Plugins e Ferramentas Utilizadas

Durante o desenvolvimento, foram utilizadas algumas ferramentas para melhorar a qualidade do código e o processo de desenvolvimento:

- **Husky com Commitizen e Commitlint**: Implementação de commits semânticos para uma melhor organização e entendimento do histórico de versionamento.

- **Gitflow**: Modelo de fluxo de trabalho Git que facilita o gerenciamento de branches e versionamento.

### Armazenamento de Dados

A biblioteca `shared_preferences` foi escolhida para armazenar informações localmente, garantindo que os dados inseridos pelo usuário persistam entre sessões do aplicativo.

### Mock API

Para simular uma API remota, o serviço [mockapi.io](https://mockapi.io/) foi utilizado. Os dados mockados dos usuários estão disponíveis no final deste README.

### Imagens de Exemplo

As imagens de exemplo para as telas de login e captura de informações não estão fornecidas aqui, mas o código foi desenvolvido para refletir fielmente o design proposto no desafio.

### Dados Mockados

Os seguintes dados foram mockados no [mockapi.io](https://mockapi.io/) e podem ser utilizados pelos avaliadores para testar a aplicação. Vale ressaltar que :
```json
[
  {
    "name": "Angelica Schmitt",
    "username": "username1",
    "password": "password1",
    "id": "1"
  },
  {
    "name": "Jessie Schroeder",
    "username": "username2",
    "password": "password2",
    "id": "2"
  },
  {
    "name": "Muriel Powlowski",
    "username": "username3",
    "password": "password3",
    "id": "3"
  },
  {
    "name": "Vickie Zemlak",
    "username": "username4",
    "password": "password4",
    "id": "4"
  },
  {
    "name": "Joann Aufderhar",
    "username": "username5",
    "password": "password5",
    "id": "5"
  },
  {
    "name": "Orville Schaefer",
    "username": "username6",
    "password": "password6",
    "id": "6"
  }
]
```


### Considerações Finais

No meu ponto de vista, o uso da Clean Architecture, mesmo em um projeto relativamente pequeno, oferece benefícios significativos em termos de manutenção, testabilidade e escalabilidade do código. A divisão clara das responsabilidades entre as camadas facilita a expansão do aplicativo e a introdução de novos recursos no futuro.

Este projeto é uma demonstração do uso de boas práticas de desenvolvimento Flutter, incluindo gerenciamento de estado com MobX, estruturação de código em camadas e integração com uma API mock para simular a comunicação remota.

Sintam-se à vontade para explorar o código-fonte e fornecer feedback. Obrigado por avaliar este projeto!





