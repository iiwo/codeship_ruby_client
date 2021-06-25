# CodeshipRubyClient

:construction: :construction: WIP :construction: :construction:

a simple Ruby wrapper for the [Codeship API](https://apidocs.codeship.com/v2/introduction/basic-vs-pro)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codeship_ruby_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install codeship_ruby_client

## Usage

example usage:
```ruby
# bin/console

client = CodeshipRubyClient::Client.new(username: 'USERNAME', password: 'PASSWORD')

# get organization
organization = client.organizations.first

# get project by name
project = organization.projects.find { |project| project.name == "PROJECT_NAME" }

# pull last 100 builds (auto-pagination) and filter by branch name and status
builds = project.builds(limit: 1000).select do |build| 
  build.branch == "master" && build.status == "success"
end

# sort builds by "build" pipeline duration
sorted_builds = builds.sort_by do |build|
  sleep(1) # there's a rate limit so sleep may be needed
  puts "fetching pipelines for: #{build.commit_message}"
  build.pipelines.select do |pipeline| 
    pipeline.type == "build" 
  end.map do |pipeline| 
    pipeline.metrics.duration
  end.max
end

fastest_builds = sorted_builds.first(2)
slowest_builds = sorted_builds.last(2)

# get pipeline metrics
slowest_builds.first.pipelines.last.metrics.to_h
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/codeship_ruby_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/codeship_ruby_client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CodeshipRubyClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/codeship_ruby_client/blob/master/CODE_OF_CONDUCT.md).
