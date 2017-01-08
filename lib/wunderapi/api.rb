module Wunderapi
  class Api

    attr_reader :access_token, :client_id

    def initialize(attributes = {})
      @access_token = attributes[:access_token]
      @client_id = attributes[:client_id]
    end

  end

end
