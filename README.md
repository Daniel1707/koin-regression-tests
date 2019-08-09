***Projeto de testes automatizados***

*Ferramentas utilizadas*

Ruby: Fácil aprendizado e simples de iniciar;
https://rubyinstaller.org/

Bundler: Para gerenciar as gems(bibliotecas) do ruby;
https://bundler.io/


*Gems utilizadas*

selenium-webdriver: Gem para realizar a automação dos testes de interface;
https://www.seleniumhq.org/

cpf_cnpj: Gem para ajudar na criação de massa de teste, criando cpf e cnpj;
https://github.com/fnando/cpf_cnpj

cucumber: Gem para auxiliar na leitura dos testes;
https://cucumber.io/

httparty: Gem para realizar chamadas para as APIs;
https://github.com/jnunemaker/httparty

gmail: Gem para interagir com e-mail do Gmail;
https://github.com/gmailgem/gmail



*Testes mapeados*

Scenario: Create authorization
Scenario: Create check
Scenario: Order from include and cancel in manual analyse
Scenario: Order from request and cancel in manual analyse
Scenario: Order from include and disapprove in manual analyse for reason Sem Contato
Scenario: Order from include and approve automatic
Scenario: Order from include and disapprove automatic
Scenario: Order from request and cancel by scheduler
Scenario: Order from include and approve in manual analyse
Scenario: Manual Analyse Approve from seller page





*Como executar*

Como default os testes são executados em PRE-PRD caso o ambiente não seja informado. Para executar testes em novos ambientes, insira os dados no arquivo features/env/AppEnvironment.rb;

Executar todas as features de teste no ambiente PRE-PRD:
. cucumber features/specification

Executar todas as features de teste escolhendo um ambiente(Risks nesse exemplo):
. cucumber features/specification env=hmg-risks

Executar feature específica de teste escolhendo um ambiente(Risks nesse exemplo):
. cucumber features/specification/end2end.feature env=hmg-risks

No log irá mostrar as features em execução e ao final as features com erro.

OBS:

Com a branch docker usando o comando docker-compose up as vezes da erro pois o container do chrome driver nao consegue registrar no container do hub, por isso a maneira que foi encontrada de executar no momento foi:
1. docker-compose up -d
2. docker-compose up;


*Idéias para o futuro*

1. Retirar os sleep e ver alguma forma de esperar mais após o momento que os elementos são encontrados. Coloquei alguns sleeps pois mesmo usando o wait do selenium, ao clicar no elemento algumas vezes ainda não é possivel clicar o elemento apesar de estar visivel;
2. Conexão com banco de dados para manipular massa de dados;
3. Integrar com Jenkins;
