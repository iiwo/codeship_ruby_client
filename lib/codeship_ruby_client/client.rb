# frozen_string_literal: true

module CodeshipRubyClient
  # API client
  class Client
    def initialize(access_token: nil, username:, password:, base_url: "https://api.codeship.com/v2/")
      self.access_token = access_token
      self.username = username
      self.password = password
      self.base_url = base_url
    end

    def get(path:, params: {})
      authenticated_get(path: path, params: params).body
    end

    def authenticate
      auth_connection.post("auth")
    end

    def auth
      @auth ||= Entities::Auth.new(client: self).fetch.tap do |auth_request|
        self.access_token = auth_request.access_token
      end
    end

    def organizations
      @organizations ||= auth.organizations
    end

    def auth!
      @auth = nil
      auth
    end

    private

      attr_accessor :username, :password, :base_url, :access_token

      def authenticated_get(path:, params: {})
        connection.get(path, params)
      end

      def auth_token
        return access_token unless access_token.nil?
      end

      def connection # rubocop:disable Metrics/MethodLength
        Faraday.new(
          url: base_url,
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json",
            "Authorization" => "Bearer #{auth_token}"
          }
        ) do |connection|
          connection.response(:json)
          connection.use Faraday::Response::RaiseError
          connection.adapter :net_http
        end
      end

      def auth_connection # rubocop:disable Metrics/MethodLength
        Faraday.new(
          url: base_url,
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        ) do |connection|
          connection.basic_auth(username, password)
          connection.response(:json)
          connection.use Faraday::Response::RaiseError
          connection.adapter :net_http
        end
      end
  end
end
