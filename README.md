# Teste do Target Sistemas 

Esse projeto foi desenvolvido como um testo para o processo seletivo de desenvolvedor flutter da Target Sistemas.

O projeto cumpre as diretrizes e requisitos enviado no e-mail e presentes no arquivo prova_flutter.pdf.

## como correr
1. Clone o repositório;
2. Abra o terminal na pasta do projeto e execute o comando ```flutter pub get``` para instalar as dependências;
3. Execute a aplicação com o comando ```flutter run```.

O APP usa a API DummyJSON, uma API fake que permite simular muitas coisas, uma delas e a autenticação.

Essa autenticação é feita com uma simples requisição POST no endpoint https://dummyjson.com/auth/login.

Esse post deve ter um JSON body no seguinte formato:

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

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
