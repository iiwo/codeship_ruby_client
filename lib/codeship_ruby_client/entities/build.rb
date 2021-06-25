# frozen_string_literal: true

module CodeshipRubyClient
  module Entities
    # a single Build
    #
    # https://apidocs.codeship.com/v2/builds/get-build
    # https://apidocs.codeship.com/v2/builds/list-builds
    class Build
      extend Forwardable
      attr_accessor :client, :data

      def_delegators(
        :data,
        :uuid,
        :project_uuid,
        :project_id,
        :organization_uuid,
        :ref,
        :commit_sha,
        :status,
        :username,
        :commit_message,
        :finished_at,
        :allocated_at,
        :queued_at,
        :links,
        :branch,
        :pr_number
      )

      def initialize(client: nil, data:)
        self.client = client
        self.data = OpenStruct.new(data)
      end

      def pipelines
        @pipelines ||= client.get(path: pipelines_path)["pipelines"].map do |pipeline|
          Pipeline.new(client: client, data: pipeline)
        end
      end

      private

        def pipelines_path
          "organizations/#{organization_uuid}/projects/#{project_uuid}/builds/#{uuid}/pipelines"
        end
    end
  end
end
