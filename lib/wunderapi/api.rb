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

    def tasks(attributes = {})
      raise ArgumentError, 'list_id cannot be nil' unless attributes[:list_id]
      attributes[:completed] ||= false
      result = call :get, 'api/v1/tasks', list_id: attributes[:list_id], completed: attributes[:completed]
      tasks = []
      result.each do |hash_task|
        attributes = hash_task.symbolize_keys
        attributes[:api] = self
        task = Task.new(attributes)
        tasks << task
      end
      tasks
    end

    def task(attributes = {})
      raise ArgumentError, 'id cannot be nil' unless attributes[:task_id]
      list_id = { list_id: attributes[:list_id] }
      result = call :get, "api/v1/tasks/#{attributes[:task_id].to_s}", list_id if attributes[:list_id]
      unless result['error']
        task = Task.new(result.symbolize_keys)
        task.api = self
        return task
      else
        return nil
      end
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
