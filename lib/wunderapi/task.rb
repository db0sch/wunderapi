require "wunderapi/helper"

module Wunderapi
  class Task

    attr_accessor :id, :title, :list_id

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
      @completed_at = attributes[:completed_at]
      @completed_by_id = attributes[:completed_by_id]
    end

  end

end
