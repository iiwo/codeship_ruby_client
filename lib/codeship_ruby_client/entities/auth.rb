# frozen_string_literal: true

module CodeshipRubyClient
  module Entities
    # https://apidocs.codeship.com/v2/authentication/authenticate
    class Auth
      extend Forwardable
      attr_accessor :client, :data

      def initialize(client:, data: {})
        self.client = client
        self.data = OpenStruct.new(data)
      end

      def fetch
        self.data = OpenStruct.new(client.authenticate.body)
        self
      end

      def organizations
        @organizations ||= data["organizations"].map do |organization|
          Organization.new(client: client, data: organization)
        end
      end

      def_delegators :data, :access_token, :expires_at
    end
  end
end
