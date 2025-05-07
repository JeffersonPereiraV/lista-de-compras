# 🛒 Lista de Compras

Uma aplicação mobile simples e funcional desenvolvida em **Flutter**, ideal para organizar listas de compras de forma prática. O app permite gerenciar tópicos e itens, calcular subtotais e o total geral, tudo com um design intuitivo e tema escuro.

---

## 📌 Visão Geral

A _Lista de Compras_ foi criada para facilitar o planejamento de compras, permitindo que o usuário:

- Crie, edite e exclua tópicos e itens;
- Marque itens como concluídos;
- Visualize subtotais por tópico e o total geral;
- Utilize busca independente por tópicos e por itens;
- Tenha seus dados salvos localmente com persistência automática.

---

## 💡 Funcionalidades

- **Tópicos**: Categorize sua lista com seções personalizadas.
- **Itens**: Nome, descrição opcional e valor por item.
- **Cálculo automático**: Subtotal por tópico + total geral em tempo real.
- **Busca inteligente**: Filtros independentes para tópicos e itens.
- **Tema escuro**: Interface moderna com cores em teal e laranja escuro.
- **Persistência local**: Dados armazenados com [`shared_preferences`].

---

## 🧠 Arquitetura Aplicada

O projeto segue uma estrutura modular e simples para facilitar a manutenção e o entendimento do código. Abaixo estão os principais componentes do projeto:

### 🔹 **SharedPreferences**

- **Serviço centralizado** (`storage.dart`): Gerencia as preferências do usuário e a persistência de dados localmente utilizando `SharedPreferences`.
- **Preferências suportadas**: Armazenamento de configurações como tema (modo escuro/claro) e idioma, além de dados específicos do usuário e tópicos.

### 🔹 **Modelos de Dados**

- **User** (`user.dart`): Representa as informações do usuário, como `name` e `currency`. A conversão entre objetos e JSON é feita utilizando os métodos `fromJson` e `toJson`.
- **Topic** (`topic.dart`): Representa os tópicos, com um nome (`name`) e uma lista de itens (`items`). A conversão entre objetos e JSON também é feita com os métodos `fromJson` e `toJson`.

### 🔹 **Acesso a Dados**

- O acesso aos dados e a persistência são feitos diretamente através do serviço **`storage.dart`**.
  - **Carregamento e salvamento dos dados**: O serviço lida com os dados do usuário e tópicos, utilizando **SharedPreferences** para armazenar e recuperar as informações.
  - Não há uma camada de **Repository Pattern** ou **DAO** adicional, pois o serviço de persistência está integrado diretamente no projeto.

### 🔹 Organização de Pastas

```text
## Estrutura do Projeto

A estrutura do projeto foi organizada para garantir uma boa manutenção e escalabilidade,
 com uma separação clara de responsabilidades entre os modelos de dados, serviços e a entrada principal do aplicativo.
  Abaixo está a explicação das pastas e arquivos principais:

lib/
├── models/ # Contém os modelos de dados do aplicativo (User, Topic, Item)
│ ├── user.dart # Modelo de dados para o usuário
│ ├── topic.dart # Modelo de dados para os tópicos de lista
│ └── item.dart # Modelo de dados para os itens dentro de cada tópico
├── services/ # Contém serviços utilitários, como persistência de dados (storage.dart)
│ └── storage.dart # Serviço responsável pela manipulação e persistência de dados locais (SharedPreferences)
└── main.dart # Arquivo principal, responsável pela execução do app e configuração inicial
```

⚙️ Requisitos
Flutter: 3.x ou superior

Dart: 2.x ou superior

Dispositivo: Android, iOS ou emulador

Dependência principal: shared_preferences

🚀 Instalação
Abra o terminal e execute:

```bash
flutter pub get
flutter run
```

🧭 Como Usar
➕ Adicionar um Tópico
Toque no botão flutuante ( + ).

Digite o nome do tópico e clique em "Salvar".

📝 Adicionar um Item
Expanda um tópico.

Toque em "Adicionar Item", preencha os dados e clique em "Adicionar".

✏️ Editar ou Excluir
Use o ícone de lápis para editar.

Use o ícone de lixeira para excluir.

✅ Marcar Concluído
Toque na caixa de seleção (checkbox) ao lado de cada item.

Use o botão no topo direito para marcar ou desmarcar todos os itens de uma vez.

🔍 Buscar
Filtro superior: busca por nome do tópico.

Filtro inferior: busca por nome ou descrição do item.

📁 Estrutura do Código
A estrutura do projeto foi organizada para facilitar manutenção e escalabilidade, seguindo boas práticas de desenvolvimento mobile com Flutter.

```

```
