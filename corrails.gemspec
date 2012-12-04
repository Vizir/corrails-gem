Gem::Specification.new do |s|
  s.name        = 'corrails'
  s.version     = '0.0.5'
  s.date        = '2012-12-02'
  s.summary     = "Gem utilizada para rastrear pedidos da Directlog ou dos Correios"
  s.description = "Gem utilizada para rastrear pedidos da Directlog ou dos Correios"
  s.authors     = ["Vizir"]
  s.email       = 'contato@vizir.com.br'
  s.files       = [
                    "lib/corrails.rb",
                    "lib/corrails/directlog.rb",
                    "lib/corrails/correios.rb",
                    "lib/corrails/model/response.rb",
                    "lib/corrails/parser/directlog_parser.rb",
                    "lib/corrails/parser/correios_parser.rb"
                  ]
  s.add_dependency "savon", "~> 1.2.0"
  s.add_dependency "nokogiri", "~> 1.5.5"
  s.homepage    =
  'http://rubygems.org/gems/corrails'
end
