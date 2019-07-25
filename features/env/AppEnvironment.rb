class AppEnvironment
  def self.get_environment_variables
    if ENV['ENV'].eql? "hmg-risks"
      ENV['LOJISTA_ENV'] = 'http://hmg-risks-front-login.koin.com.br'
      ENV['LOJISTA_USER'] = '77754962000160'
      ENV['LOJISTA_PASSWORD'] = '123456'
      ENV['LOJISTA_NAME'] = 'Teste Integração'

      ENV['EMAIL_BUYER'] = 'koinhomolog@gmail.com'
      ENV['PASSWORD_BUYER'] = 'koin@123'
      ENV['EMAIL_KOIN'] = 'naoresponder@koin.com.br'

      ENV['ACQUARIUS_ENV'] = 'http://hmg-risks-aquarius.koin.com.br/#/login'
      ENV['AQUARIUS_USER'] = 'daniel.santos'
      ENV['AQUARIUS_PASSWORD'] = 'koin@123'

      ENV['AUTHORIZATION_INCLUDE_API'] = '8F6EC0BCB5634511A01B67785054E19E,VbH1VC/EjkeSuehEjetcjjdAMRCC/vBtDL8Z980isx2PUkLr2EHOrpkNRhydjsFy90JZZb59t5mcK2CNBYNhnA==,1560797432477'
      ENV['AUTHORIZATION_REQUEST_API'] = '8F6EC0BCB5634511A01B67785054E19E,46/MzUZnkJEf8QFRgJpwa+T5vd35XJ1Sp6HdbWi/O94RI/qAtyBwNQGwNwBQeQJVohUFQeBT3CPdHyqw1QPUFA==,1563296976702'
    end
  end
end
