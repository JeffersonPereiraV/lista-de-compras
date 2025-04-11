# projeto_integrador

Uma aplicação mobile simples e funcional para gerenciar listas de compras, desenvolvida em Flutter. Permite organizar itens em tópicos, calcular subtotais e total geral, e oferece busca por tópicos e itens. Ideal para uso pessoal com um design intuitivo em tema escuro.

Visão Geral
A "Lista de Compras" foi criada para facilitar o planejamento de compras, permitindo que o usuário:

Adicione, edite e exclua tópicos e itens.
Marque itens como concluídos.
Veja o subtotal de cada tópico e o total geral no topo da tela.
Filtre tópicos e itens com duas caixas de busca independentes.
O aplicativo utiliza um tema escuro com cores em teal e laranja escuro, e os dados são salvos localmente usando SharedPreferences.

Requisitos
  Flutter: Versão 3.x ou superior
  Dart: Versão 2.x ou superior
  Dispositivo: Android, iOS ou emulador
  Dependências: Apenas shared_preferences (incluso no Flutter)

Instalação
  Instale as dependências:
    flutter pub get

  Execute o aplicativo:
    flutter run

Uso
Adicionar um Tópico:
Clique no botão flutuante (+).
Insira o nome do tópico no diálogo e clique em "Salvar".
Adicionar um Item:
Expanda um tópico e clique em "Adicionar Item".
Preencha nome, descrição (opcional) e preço, depois clique em "Adicionar".
Editar ou Excluir:
Use os ícones de edição (lápis) ou exclusão (lixeira) nos tópicos ou itens.
Marcar Itens:
Clique no checkbox ao lado de um item para marcá-lo como concluído.
Use o botão no topo direito para marcar/desmarcar todos os itens.
Buscar:
Use a primeira caixa de busca para filtrar tópicos por nome.
Use a segunda caixa para filtrar itens por nome ou descrição.

Funcionalidades
  Tópicos: Crie categorias para organizar itens.
  Itens: Adicione detalhes como nome, descrição e preço.
  Cálculo: Subtotal por tópico e total geral atualizados em tempo real.
  Busca: Filtros independentes para tópicos e itens.
  Persistência: Dados salvos localmente.
