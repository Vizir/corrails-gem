require 'thor'
require_relative 'correios'

module Corrails
  class CLI < Thor
    desc 'rastrear CODIGOS', 'rastreia um código fornecido pelo Correios'
    def rastrear(*codigos)
      c = Corrails::Correios.new
      codigos.each do |codigo|
        puts "Encomenda: #{codigo}"
        result = c.rastrear(codigo)
        if result.ok?
          result.item[:historico].each do |h|
            puts "Data #{h[:data]} - Local #{h[:local]} - Status #{h[:status]}"
          end
        else
          puts result.error_msg
        end
        puts "\n"
      end
    end
  end
end
