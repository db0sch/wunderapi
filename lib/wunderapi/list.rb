module Wunderapi
  class List

    attr_reader :uid, :owner_type, :owner_id, :list_type, :revision, :created_at, :type
    attr_accessor :title, :public

    def initialize(attributes = {})
      @type = attributes[:type]
      @uid = attributes[:id].to_i
      @title = attributes[:title]
      @owner_type = attributes[:owner_type]
      @owner_id = attributes[:owner_id].to_i
      @list_type = attributes[:list_type]
      @public = attributes[:public]
      @revision = attributes[:revision]
      @created_at = attributes[:created_at]
    end

  end
end
