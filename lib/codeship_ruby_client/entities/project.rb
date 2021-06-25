# frozen_string_literal: true

module CodeshipRubyClient
  module Entities
    # a single Project
    #
    # https://apidocs.codeship.com/v2/projects/get-project
    # https://apidocs.codeship.com/v2/projects/list-projects
    class Project
      extend Forwardable
      attr_accessor :client, :data

      def_delegators(
        :data,
        :aes_key,
        :authentication_user,
        :created_at,
        :deployment_pipelines,
        :environment_variables,
        :name,
        :notification_rules,
        :organization_uuid,
        :repository_provider,
        :repository_url,
        :setup_commands,
        :ssh_key,
        :team_ids,
        :test_pipelines,
        :type,
        :updated_at,
        :uuid
      )

      def initialize(client: nil, data:)
        self.client = client
        self.data = OpenStruct.new(data)
      end

      def fetch
        self.data = client.get(path: path)
      end

      def builds(limit: 1000)
        @builds ||= fetch_builds(limit: limit)
      end

      def builds_path
        "organizations/#{organization_uuid}/projects/#{uuid}/builds"
      end

      private

        def builds_page(page:)
          client.get(path: builds_path, params: { page: page })
        end

        def fetch_builds(limit:, items: [], page_number: 1) # rubocop:disable Metrics/MethodLength
          request_data = builds_page(page: page_number)

          items += request_data["builds"].map do |build|
            Build.new(client: client, data: build)
          end
          page = Page.new(data: request_data, limit: limit)

          if page.last_page?
            items
          else
            puts "fetching page: #{page.next_page} / #{page.total_pages}"
            fetch_builds(limit: limit, items: items, page_number: page.next_page)
          end
        end
    end
  end
end
