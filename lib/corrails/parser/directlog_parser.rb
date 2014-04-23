require 'nokogiri'
require File.expand_path('../../model/response', __FILE__)

module Corrails
  module Parser
    class DirectlogParser
      def self.parse(returnXml)
        resp = returnXml.to_hash[:consulta_status_entrega_response]
        response = Corrails::Response.new
        response.result = resp[:consulta_status_entrega_result]
        if(response.ok?)
          response.item = build_remessa(resp[:xml])
        else
          response.error_msg = get_error(resp[:xml])
        end
        response
      end

      def self.get_error xml
        xml_doc = Nokogiri::XML(xml)
        xml_doc.xpath('//mensagem').first.content
      end

      def self.build_remessa(xml)
        xml_doc = Nokogiri::XML(xml)
        numero = xml_doc.xpath('//nrremessa').first.content
        pedido = xml_doc.xpath('//nrpedido').first.content
        notafiscal = xml_doc.xpath('//nrnotafiscal').first.content
        serianota = xml_doc.xpath('//serianota').first.content

        remessa = Hash.new
        remessa[:numero] = numero
        remessa[:pedido] = pedido
        remessa[:notafiscal] = notafiscal
        remessa[:serianota] = serianota
        remessa[:historico] = get_status_list(xml_doc)
        remessa
      end

      def self.get_status_list(xml_doc)
        status_list = Array.new
        historicos = xml_doc.xpath("//historicos//status")
        historicos.each do |historico|
          status = Hash.new
          status[:codigo] = historico.xpath('codstatus').first.content
          status[:status] = historico.xpath('descricaostatus').first.content
          status[:data] = historico.xpath('dtstatus').first.content
          status[:ocorrencias] = get_ocorrencias(historico)
          status_list << status
        end
        status_list
      end

      def self.get_ocorrencias(historico)
        list = Array.new
        ocorrencias = historico.xpath('ocorrencia')
        ocorrencias.each do |ocorrencia|
          ocorren = Hash.new
          ocorren[:codigo] = ocorrencia.xpath('codocorrencia').first.content
          ocorren[:descricao] = ocorrencia.xpath('descricaoocorrencia').first.content
          list << ocorren
        end
        list
      end
    end
  end
end
