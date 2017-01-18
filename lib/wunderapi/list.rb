require "wunderapi/request"
require "wunderapi/helper"

module Wunderapi
  class List

    include Wunderapi::Helper

    attr_accessor :title, :public, :api, :id, :owner_type, :owner_id, :list_type, :revision, :created_at, :type

    def initialize(attributes = {})
      @type = attributes[:type]
      @id = attributes[:id].to_i if attributes[:id]
      @title = attributes[:title]
      @owner_type = attributes[:owner_type]
      @owner_id = attributes[:owner_id].to_i if attributes[:owner_id]
      @list_type = attributes[:list_type]
      @public = attributes[:public]
      @revision = attributes[:revision]
      @created_at = attributes[:created_at]
      @api = attributes[:api]
      raise ArgumentError, 'title cannot be nil' unless @title
    end

    def tasks(attributes = {completed: false})
      api.tasks list_id: self.id, completed: attributes[:completed]
    end

    def all_task
      api.tasks list_id: self.id
    end

    def completed_tasks
      tasks completed: true
    end

    def task(id)
      api.task list_id: self.id, task_id: id
    end

    def new_task(attributes = {})
      attributes[:list_id] = self.id
      attributes[:api] = self.api
      Task.new(attributes)
    end

    def set_attrs(attrs = {})
      self.api ||= attrs[:api]
      self.id = attrs[:id]
      self.type = attrs[:type]
      self.owner_type = attrs[:owner_type]
      self.owner_id = attrs[:owner_id]
      self.list_type = attrs[:list_type]
      self.public = attrs[:public]
      self.title = attrs[:title]
      self.created_at = attrs[:created_at]
      self.revision = attrs[:revision]
    end
  end
end
