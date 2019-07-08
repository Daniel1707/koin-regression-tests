require 'selenium-webdriver'
require './pages/lojistaPage'
require './pages/AcquariusPage'
require './utils/Email'
require 'date'
require './env/Hmg'
require 'cpf_cnpj'

#Selenium::WebDriver::Chrome.driver_path = File.join(File.absolute_path(File.dirname(__FILE__)),"driver","chromedriver.exe")
Selenium::WebDriver::Chrome::Service.driver_path=File.join(File.absolute_path(File.dirname(__FILE__)),"driver","chromedriver.exe")

options = Selenium::WebDriver::Chrome::Options.new#(args: ['headless'])
options.add_argument('--ignore-certificate-errors')
options.add_argument('--disable-popup-blocking')
options.add_argument('--disable-translate')

options.add_argument('--no-sandbox')
options.add_argument('--disable-gpu')
options.add_argument('--disable-dev-shm-usage')
@driver = Selenium::WebDriver.for :chrome, options: options
@wait = Selenium::WebDriver::Wait.new(:timeout => 10)

acquariusPage = AcquariusPage.new(@driver, @wait)
acquariusPage.openPage
acquariusPage.login(ENV['USER_AQUARIUS'], ENV['PASSWORD_AQUARIUS'])

lojistaPage = LojistaPage.new(@driver, @wait)
lojistaPage.openPage

lojistaPage.login(ENV['LOJISTA_USER'], ENV['LOJISTA_PASSWORD'])

lojistaPage.clickRequestPayment

pedidoRandom = rand(10000000..99999999)

amount = "500000"

lojistaPage.fillPaymentSolicitation(pedidoRandom, CPF.generate, "20112019", amount)
lojistaPage.clickConsultAvailability

lojistaPage.clickIncludeSolicitation

lojistaPage.fillIncludeSolicitation("Teste", "Teste", "17/07/1991", "(99)99999-9999", "#{pedidoRandom}@koin.com.br", "06122-100", "12")

lojistaPage.clickHospedagem

lojistaPage.fillHospedagem("Teste Hospede", "20112019", "25112019", "Daniel", "Teste")
lojistaPage.clickAddGuest

lojistaPage.fillOrderData(pedidoRandom, "20112019", "1200", amount)
lojistaPage.clickRequestPaymentSolicitation
lojistaPage.clickConfirmSolicitation




acquariusPage = AcquariusPage.new(@driver, @wait)
acquariusPage.openPage
acquariusPage.login(ENV['AQUARIUS_USER'], ENV['AQUARIUS_PASSWORD'])
