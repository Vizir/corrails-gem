require 'rubygems'
require 'savon'
require File.expand_path('../parser/directlog_parser', __FILE__)
require File.expand_path('../model/response', __FILE__)

module Corrails
  
  class Directlog
    attr_accessor :wsdl 
    def initialize(wsdl)
      @client = Savon.client(wsdl);
    end

    def rastrear(login, password, pedido)
      resp = Response.new
      begin
        xml = "&lt;?xml version=&quot;1.0&quot; encoding=&quot;ISO-8859-1&quot; ?&gt;&lt;directlog&gt;&lt;parametros&gt;&lt;parametro name=&quot;pedido&quot;&gt;#{pedido}&lt;/parametro&gt;&lt;/parametros&gt;&lt;/directlog&gt;"
        response = @client.request :consulta_status_entrega, :xmlns => 'http://www.directlog.com.br/' do
          soap.namespaces["xmlns:soap"] = "http://schemas.xmlsoap.org/soap/envelope/"
          soap.body = "<login>#{login}</login><password>#{password}</password><xml>#{xml}</xml><type>DEFAULT</type>" 
        end
        resp = Parser::DirectlogParser.parse(response)
      rescue => e
        resp.error_msg=e.message
      end
      resp
    end
  end

end
