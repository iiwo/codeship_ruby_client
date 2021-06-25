# frozen_string_literal: true

module CodeshipRubyClient
  module Entities
    # a single Pipeline
    #
    # https://apidocs.codeship.com/v2/builds/get-build-pipelines
    class Pipeline
      extend Forwardable
      attr_accessor :client, :data

      def_delegators(
        :data,
        :uuid,
        :build_uuid,
        :type,
        :status,
        :created_at,
        :updated_at,
        :finished_at
      )

      def initialize(client: nil, data:)
        self.client = client
        self.data = OpenStruct.new(data)
      end

      def metrics
        @metrics ||= Metrics.new(data["metrics"])
      end

      def type
        data["type"]
      end
    end
  end
end
