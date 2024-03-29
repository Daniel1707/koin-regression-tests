***<h1>Projeto de testes automatizados</h1>***


<h2>- Ferramentas utilizadas</h2>

*Ruby:* Fácil aprendizado e simples de iniciar;

https://rubyinstaller.org/

*Bundler:* Para gerenciar as gems(bibliotecas) do ruby;

https://bundler.io/


<h2>- Gems utilizadas</h2>

*selenium-webdriver:* Gem para realizar a automação dos testes de interface;

https://www.seleniumhq.org/

*cpf_cnpj:* Gem para ajudar na criação de massa de teste, criando cpf e cnpj;

https://github.com/fnando/cpf_cnpj

*cucumber:* Gem para auxiliar na leitura dos testes;

https://cucumber.io/

*httparty:* Gem para realizar chamadas para as APIs;

https://github.com/jnunemaker/httparty

*gmail:* Gem para interagir com e-mail do Gmail;

https://github.com/gmailgem/gmail


<h2>- Padrões utilizados</h2>

*PageObect:* Padrão utlizado para mapear páginas html; 

https://medium.com/@nelson.souza/page-object-design-pattern-ed5f6374d32d


<h2>- Testes mapeados</h2>

Scenario: Create authorization

Scenario: Create check

Scenario: Order from include and cancel in manual analyse

Scenario: Order from request and cancel in manual analyse

Scenario: Order from include and disapprove in manual analyse for reason Sem Contato

Scenario: Order from include and approve automatic

Scenario: Order from include and disapprove automatic (Esta com erro pois o CPF que deveria reprovar automaticamente não esta fazendo isso)

Scenario: Order from request and cancel by scheduler

Scenario: Order from include and approve in manual analyse

Scenario: Manual Analyse Approve from seller page


<h2>- Como executar</h2>

Para executar testes em novos ambientes, insira os dados do ambiente no arquivo features/env/AppEnvironment.rb;

Executar todas as features de teste no ambiente default:
. cucumber features/specification

Executar todas as features de teste escolhendo um ambiente(Risks nesse exemplo):
. cucumber features/specification env=hmg-risks

Executar feature específica de teste escolhendo um ambiente(Risks nesse exemplo):
. cucumber features/specification/end2end.feature env=hmg-risks

No log irá mostrar as features em execução e ao final as features com erro.

<h2>OBS:</h2>

Com a branch **docker** usando o comando **docker-compose** up as vezes da erro pois o container do **chrome** nao consegue registrar no container do **hub**, por isso a maneira que foi encontrada de executar no momento foi:
1. docker-compose up -d
2. docker-compose up;


<h2>- Idéias para o futuro</h2>

1. Retirar os sleep e ver alguma forma de esperar mais após o momento que os elementos são encontrados. Coloquei alguns sleeps pois mesmo usando o wait do selenium, ao clicar no elemento algumas vezes ainda não é possivel clicar o elemento apesar de estar visivel;
2. Conexão com banco de dados para manipular massa de dados;
3. Integrar com Jenkins;
4. Verificar forma de executar docker-compose sem erro de registro do nó no hub;
