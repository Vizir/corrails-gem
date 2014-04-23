module Corrails
class Response
  attr_accessor :result, :error_msg, :item, :status

  def initialize
  end

  def ok?
    result == true
  end
end

end
