require 'net/http'
require File.expand_path('../parser/correios_parser', __FILE__)
module Corrails

  class Correios
    def rastrear(id_objeto)
      uri = URI.parse("http://websro.correios.com.br/sro_bin/txect01$.QueryList");

      params = {
        'P_LINGUA' => '001',
        'P_TIPO' => '001',
        'P_COD_UNI' => id_objeto
      }

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path)
      request.set_form_data( params )
      request = Net::HTTP::Get.new( uri.path+ '?' + request.body )
      response = http.request(request)
      Parser::CorreiosParser.parse(response.body)
    end
  end

end
