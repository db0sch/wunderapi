require "wunderapi/request"
require "wunderapi/list"
require "wunderapi/helper"

module Wunderapi
  class Api

    attr_reader :access_token, :client_id

    def initialize(attributes = {})
      @access_token = attributes[:access_token]
      @client_id = attributes[:client_id]
      @request = Wunderapi::Request.new(api: self)
    end

    def lists
      result = call :get, 'api/v1/lists'
      lists = []
      result.each do |hash_list|
        attributes = hash_list.symbolize_keys
        list = List.new(attributes)
        lists << list
      end
      lists
    end

    def call(method, url, options = {})
      case method
      when :get then @request.get(url, options)
      when :post then @request.post(url, options)
      when :put then @request.put(url, options)
      when :delete then @request.delete(url, options)
      end
    end

  end

end
