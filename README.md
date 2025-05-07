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
- **Persistência local**: Dados armazenados com [`shared_preferences`](https://pub.dev/packages/shared_preferences).

---

## 🧠 Arquitetura Aplicada

O projeto segue uma estrutura modular e limpa:

### 🔹 SharedPreferences

- Serviço centralizado (`storage.dart`) para configurações do usuário;
- Suporte a preferências como tema e idioma.

### 🔹 Repository Pattern

- DAOs para acesso local aos dados (`user_dao.dart`, `topic_dao.dart`);
- Repositórios intermediários (`user_repository.dart`, `topic_repository.dart`) para desacoplar lógica de negócio da camada de dados.

### 🔹 Organização de Pastas

`````text
lib/
├── dao/             # Acesso direto a SharedPreferences
├── models/          # Modelos de dados (User, Topic, Item)
├── repositories/    # Camada intermediária para lógica de acesso
├── services/        # Serviços utilitários (ex: storage.dart)
└── main.dart        # Entrada principal

⚙️ Requisitos
Flutter: 3.x ou superior

Dart: 2.x ou superior

Dispositivo: Android, iOS ou emulador

Dependência principal: shared_preferences

🚀 Instalação
Abra o terminal e execute:

````bash
flutter pub get
flutter run

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
`````
