# Teste do Target Sistemas 

Este projeto foi desenvolvido como um teste para o processo seletivo de desenvolvedor Flutter na Target Sistemas.

O projeto atende às diretrizes e requisitos enviados por e-mail, conforme detalhados no arquivo 'prova_flutter.pdf'.

## Como Executar
1. Clone o repositório;
2. Abra o terminal na pasta do projeto e execute o comando ```flutter pub get``` para instalar as dependências;
3. Execute a aplicação com o comando ```flutter run```.

O aplicativo utiliza a API DummyJSON, uma API fictícia que possibilita simular diversas funcionalidades, incluindo a autenticação.

O processo de autenticação é realizado por meio de uma requisição POST simples no endpoint https://dummyjson.com/auth/login.

Essa requisição deve ter um JSON no body no seguinte formato:

    {
        username: 'username',
        password: 'password'
    }

  Para fazer teste no APP use uma das seguintes credencias:

    username: kminchelle,
    password: 0lelplR

Ou

    username: atuny0,
    password: 9uQFF1Lh

Você pode encontrar outras credencias nesse link: https://dummyjson.com/users.

## Project Structure
O projeto possui a seguinte estrutura:

**lib**: diretório principal;
   - **core**: diretório com objetos e classes gerais
   - **data**: camada de infraestrutura, com todas as classes de repositórios e de acesso a serviços;
   - **domain**: camada de domínio, com todas as entidades, regras de negócio e interface de repositórios;
   - **presentation**: camada de aplicação, com todas as classes, visualizações e blocos da apresentação;

## Testes
Os Testes podem ser encontrados no diretorio test/.

## Autor
Althierfson Tullio
