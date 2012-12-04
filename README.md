corrails-gem
============

Gem utilizada para rasttrear itens da Directlog e/ou dos Correios.

Instalação
=========
gem install corrails

Exemplo Directlog
=================
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

Exemplo Correios
===============
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

