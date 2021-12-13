
![logo Banco Modal Mais](logomodalmais.png)

<h1 align="center">Desafio iOS Modal 🍎</h1>

  > O nosso objetivo foi construir uma aplicação iOS usando Swift para consumir a API do GitHub seguindo o escopo do desafio do Banco Modal.

## Escopo do Projeto 🖥️
-   View da Home 🆗
-   View de Filtro 🆗
-   View de Detalhes 🆗
-   Fazer uma busca por nome do repositório 🆗  
-   Criar um filtro por estrelas, seguidores e data do último commit❗
> O filtro por estrela funciona corretamente. Entretanto, não encontramos um endpoint que retorna os dados ordenados por seguidores ou pela data do último commit. Além disso, não tivemos contato com a utilização de APIs em swift, o que atrasou a implementação de requests HTTP. Uma solução seria receber todos os dados da busca por nome e ordená-los por seguidores ou data do último commit dentro da aplicação.
-   Mostrar ícone e informações básicas do repo 🆗
-   Paginação com rolagem infinita 🆗
-   Puxe para atualizar a lista de repositórios 🆗
-  Autenticação da API do GitHub❗
> Utilizamos um Personal Access Token para aumentarmos o limite de requisições para a API do GitHub. O ideal seria utilizar o GitHub Apps, mas não tivemos tempo de estudá-la e implementá-la.

> ‼️ OBS: Removemos o Personal Access Token para que o app fosse utilizável por alguém sem o token, entretanto isso reduziu consideravelmente o número de requests que a aplicação pode fazer. ‼️
-  ViewModels❗
> Não conheciámos o RxSwift e nem o MVVM-C, então tivemos dificuldade em implementá-los adequadamente.

## Telas  🏠🔖🔍
![telas](telas.png)


## Autores 🚀

👨‍🚀 [Aryel Santos](https://github.com/aryelsander)     👨‍🚀 [Victor Magdesian](https://github.com/victormagdesian)     👨‍🚀 [Victor Moura](https://github.com/vitutiv)     👨‍🚀 [Gabriel Matheus](https://github.com/gabrielrom)     👨‍🚀 [Pedro Castro](https://github.com/pedrogaldiano)

![Logo Vaivoa](logovaivoa.png)



## Requisitos 🧾

- Higher Order Functions ☑️
- Autolayout ☑️
- MVVM-C ☑️
- Xib - Não use Storyboard ou ViewCode ☑️
- Xcode 13.1+ ☑️
- iOS 13.0+ ☑️
- Swift 5+ ☑️
- Swiftlint ☑️
- SPM ☑️
- RxSwift – Única framework a ser adicionada no projeto ☑️

## Plus ➕

- Unit/UI Tests XCTests
- Componentes customizados
- Fonte customizadas
- l10n

## PlusPlus ➕➕

- Faça tudo usando SwiftUI com Combine

## Entrega e Prazo 📅

Você tem uma semana para terminar o teste e enviar o link do teste publicado no Github.
