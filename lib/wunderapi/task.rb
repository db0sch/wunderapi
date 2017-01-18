require "wunderapi/helper"

module Wunderapi
  class Task

    include Wunderapi::Helper

    attr_accessor :id, :title, :list_id, :api, :assignee_id, :created_at, :created_by_id
    attr_accessor :due_date, :revision, :starred, :completed_at, :completed_by_id

    def initialize(attributes = {})
      @id = attributes[:id]
      @assignee_id = attributes[:assignee_id]
      @created_at = attributes[:created_at]
      @created_by_id = attributes[:created_by_id]
      @due_date = attributes[:due_date]
      @list_id = attributes[:list_id]
      @revision = attributes[:revision]
      @starred = attributes[:starred]
      @title = attributes[:title]
      @completed = attributes[:completed_at] ? true : false
      @completed_at = attributes[:completed_at]
      @completed_by_id = attributes[:completed_by_id]
      @api = attributes[:api]
      raise ArgumentError, 'list_id cannot be nil' unless @list_id
      raise ArgumentError, 'title cannot be nil' unless @title
    end

    def completed!(attributes = {})
      @completed = true
    end

    def completed?
      @completed
    end

    def uncompleted!
      @completed = false
    end

    def uncompleted?
      !@completed
    end

    def starred!
      @starred = true
    end

    def starred?
      @starred
    end

    def unstarred!
      @starred = false
    end

    def set_attrs(attrs = {})
      self.api ||= attrs[:api]
      self.id = attrs[:id]
      self.assignee_id = attrs[:assignee_id]
      self.created_at = attrs[:created_at]
      self.created_by_id = attrs[:created_by_id]
      self.due_date = attrs[:due_date]
      self.list_id = attrs[:list_id]
      self.revision = attrs[:revision]
      self.starred = attrs[:starred]
      self.title = attrs[:title]
      self.completed_at = attrs[:completed_at]
      self.completed_by_id = attrs[:completed_by_id]
    end

  end

end
