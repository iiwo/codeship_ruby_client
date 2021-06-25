# frozen_string_literal: true

module CodeshipRubyClient
  module Entities
    # Pipeline metrics
    #
    # https://apidocs.codeship.com/v2/builds/get-build-pipelines
    #
    # {
    #   "ami_id"=>"ami-037335cda685adb4c",
    #   "queries"=>"7",
    #   "cpu_user"=>"2805",
    #   "duration"=>"25",
    #   "cpu_system"=>"2738",
    #   "instance_id"=>"i-0ffca526d514fd669",
    #   "instance_type"=>"i3.16xlarge",
    #   "cpu_per_second"=>"213",
    #   "disk_free_bytes"=>"257137725440",
    #   "disk_used_bytes"=>"699990016",
    #   "network_rx_bytes"=>"51189631",
    #   "network_tx_bytes"=>"896616",
    #   "max_used_connections"=>"2020-06-14 22:15:16",
    #   "memory_max_usage_in_bytes"=>"1446817792"
    # }
    class Metrics < OpenStruct
      def duration
        super.to_i
      end

      def cpu_per_second
        super.to_i
      end
    end
  end
end
