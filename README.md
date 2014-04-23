# corrails-gem

Gem utilizada para rastrear despachados através de diversos agentes de logísticas, atualmente é possível rastrear itens despachados através das seguintes empresas:
* [Correios](http://www.correios.com.br)
* [DirectLog](http://www.directlog.com.br)

## Instalação

### Ambiente sem Rails
gem install corrails

### Instalação em ambiente rails
Adicionar a gem corrails ao Gemfile conforme abaixo

```ruby
gem 'corrails'
```

Executar o comando bundle install para instalar a gem.


## Exemplo Directlog

```ruby
require 'rubygems'
require 'corrails'

login = '1234'
password = '5678'
pedido = '91011'

directlog = Corrails::Directlog.new
response = directlog.rastrear(login, password, pedido)

if(response.ok?)
  item = response.item
  item_pedido = item[:pedido]
  item_notafiscal = item[:notafiscal]
  item_serianota = item[:serianota]
  item_historico = item[:historico]

  item_historico.each do |h|
    codigo = h[:codigo]
    status = h[:status]
    data = h[:data]
    ...
  end
else
  error = response.error_msg
end

```

## Exemplo Correios
```ruby
require 'rubygems'
require 'corrails'

correios = Corrails::Correios.new
response = correios.rastrear('SS123456789BR')

if response.ok?
  historico =  response.item[:historico]
  historico.each do |h|
    status = h[:status]
    data =  h[:data]
    local = h[:local]
    ...
  end
else
  error = response.error_msg
end

```

