# -*- encoding : utf-8 -*-
require File.expand_path('../../model/response', __FILE__)

module Corrails
  module Parser
    class CorreiosParser

     def self.parse(html)
        response = Corrails::Response.new
        regex = /^<tr><td rowspan=.*>(.*)<\/td><td>(.*)<\/td><td><FONT COLOR=".*">(.*)<\/font><\/td><\/tr>$/
        historicos = []
        html.scan(regex) do |data, local, status|
        historicos.push({
            :data => data,
            :local => local,
            :status => status
            })
        end

        if not (historicos.empty?)
          response.result = true
          response.item = Hash.new
          response.item[:historico] = historicos
        else
          response.error_msg = 'O nosso sistema não possui dados sobre o objeto informado. Verifique se o código digitado está correto'
        end
        response
      end

   end
  end
end
