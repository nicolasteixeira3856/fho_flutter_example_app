
# API

Para iniciar a API, execute o seguinte comando em um terminal dentro da pasta `exam_api`:
```bash
dart run bin/main.dart
```

# App

Para configurar a URL que fará os disparos, certifique-se de alterar a URL no arquivo `.env` na raiz da pasta do app. Atualmente, a configuração está adequada para o emulador Android utilizado no Android Studio.

# Testes unitários

Implementei vários testes unitários para todas as classes de cada divisão de camadas. Para executá-los, use o comando:
```bash
flutter test --coverage
```
De forma opcional, você pode verificar a cobertura dos testes com a extensão flutter-coverage no VSCode. Na execução dos meus testes, o coverage alcançado foi de 90.3% no app e 100% na API.

# Arquitetura do App

## Estrutura do Projeto

Desenvolvi a estrutura de pastas seguindo a proposta da Clean Architecture, com foco em modularização e escalabilidade. A estrutura principal inclui:

- `lib/`: Contém pastas como `config/` e `features/`.
- `di.dart`: Arquivo para configuração de injeção de dependência utilizando `get_it`.
- `main.dart`: Ponto de entrada da aplicação.

## Clean Architecture

Esta arquitetura é projetada para maximizar a organização, a testabilidade e a manutenibilidade do código. Ela separa claramente as responsabilidades em três camadas principais: Data, Domain e Presentation, com cada uma responsável por um aspecto distinto da aplicação. A organização por features dentro dessas camadas aumenta a clareza e facilita a escalabilidade do projeto. Abaixo, detalho cada camada:

### Data Layer

Essa camada é o ponto de acesso aos dados necessários para o funcionamento da aplicação. Ela é composta por:

- **Datasources**: Classes e abstrações que gerenciam a obtenção de dados de fontes externas como APIs.
- **Models**: Representações dos dados que circulam entre as camadas. São geralmente implementados como classes simples com funções fromJson e estendem as entities.
- **Repositories**: Implementam os contratos definidos no domínio para acessar os dados. Os repositórios são responsáveis por coordenar os dados vindos dos diversos datasources, e fornecer esses dados para as outras camadas.

### Domain Layer

Considerada o coração da aplicação, esta camada contém toda a lógica de negócio e regras que definem e manipulam os dados. Ela é crucial para o funcionamento independente do core da aplicação em relação a qualquer framework ou biblioteca externa. Esta camada inclui:

- **Entities**: São os objetos de domínio que encapsulam os dados mais importantes e as regras de negócio da aplicação. 
- **Use Cases**: Contém a lógica de negócios específica e os casos de uso da aplicação. Cada use case representa uma ação específica que o usuário pode realizar.
- **Repositories(Interfaces)**: Definem os contratos para os repositórios implementados na camada de dados, garantindo que o domínio não dependa de detalhes de implementação da camada de dados.

### Presentation Layer

Esta camada gerencia tudo o que é relacionado à interface do usuário. Ela interage diretamente com a camada de domínio para receber e apresentar dados, e reagir às interações do usuário. Esta camada é composta por:

- **Cubits**: Gerenciam o estado da UI baseando-se nos eventos ou ações do usuário. Eles solicitam dados ao domínio e recebem esses dados para transformá-los em estados que a UI pode consumir.
- **Pages**: São os componentes que definem a estrutura visual e o comportamento da aplicação. Eles utilizam os Cubits para mostrar os dados na tela e interagir com o usuário.

A estruturação em Clean Architecture facilita a manutenção e expansão do app, além de permitir uma maior testabilidade dos componentes isoladamente.


## Dependências do Projeto

- **flutter_bloc**: Para implementação do padrão BLoC, gerenciando o estado do aplicativo através de streams.
- **get_it**: Ferramenta para localização de serviço, usada para injeção de dependência.
- **go_router**: Para gerenciamento de rotas no aplicativo.
- **equatable**: Facilita comparações entre objetos em Dart, eliminando a necessidade de sobrescrever manualmente métodos como `==` e `hashCode`.
- **http**: Adotado por sua confiabilidade e robustez, mantido pelo time oficial do Dart. Seguindo os princípios da Clean Architecture, utilizamos uma abstração ao invés de uma dependência direta no `http`.
- **flutter_dotenv**: Utilizado para suporte de arquivos de ambiente.

## Dependências de Desenvolvimento

- **Mocktail**: Utilizado em testes unitários para criação de mocks e stubs.
- **bloc_test**: Dependência do BLOC para realização de testes em blocs e cubits.

## Fontes

- [The Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- Robert C Martin. *Clean Architecture: A Craftsman's Guide to Software Structure and Design*.
- [Clean Dart - Flutterando](https://github.com/Flutterando/Clean-Dart)