# frozen_string_literal: true

module CodeshipRubyClient
  module Entities
    # pagination
    #
    # https://apidocs.codeship.com/v2/introduction/pagination
    class Page
      attr_accessor :client, :data, :limit

      def initialize(data:, limit: 1000)
        self.data = OpenStruct.new(data)
        self.limit = limit
      end

      def total
        total_value = data["total"].to_i
        total_value > limit ? limit : total_value
      end

      def page
        data["page"].to_i
      end

      def per_page
        data["per_page"].to_i
      end

      def total_pages
        (total.to_f / per_page).ceil
      end

      def last_page?
        page >= total_pages
      end

      def next_page
        return if last_page?

        page + 1
      end
    end
  end
end
