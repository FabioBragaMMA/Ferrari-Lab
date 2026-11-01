Ferrari Lab — Documentação Completa do Projeto
A Ferrari Lab é uma aplicação móvel de telemetria, diagnóstico em tempo real e controlo inteligente de veículos desportivos de elite (com foco de demonstração no Ferrari F50 — Versão Corsa Track Pack), desenvolvida com a framework Flutter e a linguagem Dart. Este documento descreve de forma exaustiva todas as funcionalidades implementadas, a organização detalhada do código-fonte por pastas e ficheiros, e as soluções arquiteturais adotadas no âmbito do percurso académico em Desenvolvimento de Aplicações Móveis (IPCA).

Estrutura de Pastas e Distribuição de Componentes
Todo o código de lógica, estado e interface encontra-se estruturado de forma estrita dentro do diretório principal lib/, promovendo uma arquitetura limpa, legível e de fácil manutenção. Abaixo encontra-se o mapa detalhado de onde está cada elemento da aplicação:

1. lib/core/ (O Núcleo da Aplicação)
Esta pasta centraliza as configurações globais, utilitários transversais e motores de lógica de negócio que servem toda a aplicação de forma desacoplada.

main.dart (na raiz/núcleo): O ficheiro mestre que inicializa o ciclo de vida global da app, injeta o gestor de tema global (isDarkModeNotifier) e define as rotas de navegação iniciais.

2. lib/screens/ (Ecrãs Principais / Camada de View)
Cada ficheiro nesta pasta representa uma interface ou ecrã inteiro que o utilizador visualiza ao navegar:

splash_screen.dart: O ecrã de carregamento e arranque inicial (Splash Screen). Exibe o logótipo personalizado oficial (ScuderiaLab.png) em destaque de grande formato e um botão interativo dedicado para estabelecer a ligação OBD-II / Bluetooth ao veículo.

dashboard_screen.dart: O centro de controlo visual da app. Apresenta o estado dinâmico da conexão ao veículo, os cartões interativos de telemetria (Pressão dos Pneus e Nível de Combustível), o painel de Temperatura do Carro (com limites estritos de segurança entre 16°C e 30°C), e atalhos rápidos para o perfil e assistência técnica.

user_profile_screen.dart: Ecrã dedicado à gestão e edição em tempo real dos dados do condutor e do veículo (Nome do Condutor, Modelo do Veículo, Email e Telemóvel), com sincronização imediata e bidirecional de volta para o dashboard.

detail_screen.dart: Ecrã modular de detalhes técnicos e relatórios de diagnóstico em tempo real (como o estado geral, autonomia estimada e recomendações de combustível).

car_control_screen.dart: Painel de controlo avançado para configurações adicionais do veículo e parâmetros do motor V12 de 4.7L.

3. lib/widgets/ (Componentes Visuais Reutilizáveis)
Aloja pequenos blocos visuais modulares que são partilhados por múltiplos ecrãs para evitar duplicação de código:

action_card.dart: Um cartão de ação altamente customizável e reutilizável para as grelhas de telemetria, adaptando-se de forma fluida aos modos claro e escuro.

4. assets/images/ (Recursos Visuais e Assets)
Contém o logótipo oficial personalizado da marca (ScuderiaLab.png), devidamente registado e mapeado no ficheiro de configuração pubspec.yaml para leitura imediata pelo motor do Flutter.

Detalhe Técnico das Funcionalidades da App
Conexão e Sincronização Dinâmica (Simulação OBD-II)
A aplicação simula de forma realista o ecossistema de comunicação com o veículo através de uma ponte assíncrona:

Arranque Protegido: O utilizador interage diretamente com o botão de conexão no ecrã inicial para iniciar o protocolo de comunicação.

Feedback Visual: Notificações em tempo real (SnackBars) confirmam o sucesso da sincronização com o modelo do veículo selecionado.

Gestão de Perfil com Sincronização Bidirecional (Navigator.pop & async/await)
Para garantir uma experiência de utilização fluida e sem perdas de contexto:

A edição dos dados pessoais e do veículo no user_profile_screen.dart é devolvida de forma segura ao dashboard_screen.dart através de parâmetros passados no fecho da rota (Navigator.pop), atualizando de imediato o nome do condutor, os contactos e as referências visuais no topo da aplicação.

Controlo Térmico e Validação de Limites
O módulo de controlo da Temperatura do Carro possui uma lógica de proteção integrada:

Impede valores fora do intervalo seguro estipulado (mínimo de 16°C e máximo de 30°C), exibindo avisos visuais caso os limites sejam atingidos.

Experiência Visual e UI (Interface de Utilizador)
A identidade visual foi construída com foco na sobriedade e na estética desportiva:

Paleta de Cores: Assenta em tons profundos de vermelho escuro e gradientes dinâmicos de alta performance inspirados na Scuderia.

Modo Dia / Modo Noite: Suporte integrado a temas visuais alternativos adaptados tanto para condução diurna como noturna.

Tratamento Defensivo e Robustez
A aplicação foi estruturada de forma a evitar quebras de execução (crashes), utilizando variáveis com tipagem estrita em Dart e blocos condicionais defensivos para o estado de ligação do veículo e carregamento de assets.