require "faraday"
require "json"

module Wunderapi
  class Request

    attr_reader :conn

    API_URL = "https://a.wunderlist.com"

    def initialize(attributes = {})
      @conn = conn
      @api = attributes[:api]
    end

    def conn
      @conn ||= Faraday::Connection.new(:url => API_URL) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Adapter::NetHttp
      end
    end

    def get(url, options = {})
      response = conn.get do |req|
        req.url url
        if options
          options.each do |k, v|
            req.params[k] = v
          end
        end
        req.headers = {
          'X-Access-Token' => @api.access_token,
          'X-Client-ID' => @api.client_id
        }
      end
      JSON.parse(response.body)
    end

    def post(url, options = {})
      response = conn.post do |req|
        req.url url
        req.body = options.to_json
        req.headers = {
          'X-Access-Token' => @api.access_token,
          'X-Client-ID' => @api.client_id,
          'Content-Type' => 'application/json',
          'Content-Encoding' => 'UTF-8'
        }
      end
      JSON.parse(response.body)
    end

    def put(url, options = {})
      response = conn.put do |req|
        req.url url
        req.body = options.to_json
        req.headers = {
          'X-Access-Token' => @api.access_token,
          'X-Client-ID' => @api.client_id,
          'Content-Type' => 'application/json',
          'Content-Encoding' => 'UTF-8'
        }
      end
      JSON.parse(response.body)
    end

    def delete(url, options = {})
      response = conn.delete do |req|
        req.url url
        req.params[:revision] = options[:revision]
        req.headers = {
          'X-Access-Token' => @api.access_token,
          'X-Client-ID' => @api.client_id,
          'Content-Encoding' => 'UTF-8'
        }
      end
      response.status
    end
  end
end
