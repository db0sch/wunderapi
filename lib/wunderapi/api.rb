require "wunderapi/request"
require "wunderapi/helper"
require "wunderapi/list"
require "wunderapi/task"

module Wunderapi
  class Api

    attr_reader :access_token, :client_id

    def initialize(attributes = {})
      @access_token = attributes[:access_token]
      @client_id = attributes[:client_id]
      @request = Wunderapi::Request.new(api: self)
      raise ArgumentError, 'access_token cannot be nil' unless @access_token
      raise ArgumentError, 'client_id cannot be nil' unless @client_id
    end

    def lists
      result = call :get, 'api/v1/lists'
      lists = []
      result.each do |hash_list|
        attributes = hash_list.symbolize_keys
        attributes[:api] = self
        list = List.new(attributes)
        lists << list
      end
      lists
    end

    def list_with_id(id)
      result = call :get, "api/v1/lists/#{id}"
      return nil if result['error']
      list = Wunderapi::List.new(result.symbolize_keys)
      list.api = self
      list
    end

    def new_list(title)
      list = Wunderapi::List.new(title: title)
      list.api = self
      list
    end

    def new_task(attributes = {})
      # if no list is specified, put the task in inbox (what's id of inbox?)
      task = Wunderapi::Task.new(attributes)
      task.api = self
      task
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
