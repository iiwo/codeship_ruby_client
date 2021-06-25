# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "json"
require_relative "codeship_ruby_client/version"
require_relative "codeship_ruby_client/client"
require_relative "codeship_ruby_client/entities/auth"
require_relative "codeship_ruby_client/entities/organization"
require_relative "codeship_ruby_client/entities/project"
require_relative "codeship_ruby_client/entities/build"
require_relative "codeship_ruby_client/entities/pipeline"
require_relative "codeship_ruby_client/entities/metrics"
require_relative "codeship_ruby_client/entities/page"

module CodeshipRubyClient
  class Error < StandardError; end
end
