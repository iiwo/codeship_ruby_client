# frozen_string_literal: true

module CodeshipRubyClient
  module Entities
    # https://apidocs.codeship.com/v2/authentication/authenticate
    class Organization
      extend Forwardable

      def_delegators(
        :data,
        :uuid,
        :name
      )

      attr_accessor :client, :data

      def initialize(client: nil, data:)
        self.client = client
        self.data = OpenStruct.new(data)
      end

      def projects
        @projects ||= client.get(path: "organizations/#{uuid}/projects")["projects"].map do |project|
          Project.new(client: client, data: project)
        end
      end
    end
  end
end
