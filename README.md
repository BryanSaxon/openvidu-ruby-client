# OpenVidu Ruby Client

![Build Status](https://travis-ci.org/BryanSaxon/openvidu-ruby-client.svg?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_vidu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install open_vidu

## Usage

To get started locally, first pull the OpenVidu Docker image and start a container:

```bash
docker pull openvidu/openvidu-server-kms
docker run -p 4443:4443 -d --rm -e openvidu.secret=MY_SECRET -e openvidu.recording.path=/recordings -e openvidu.recording=true -v /var/run/docker.sock:/var/run/docker.sock openvidu/openvidu-server-kms
```

Set the following environment variables in your Ruby application:

To start a OpenVidu session:

```ruby
server = 'https://127.0.0.1:4443?token=MY_SECRET'

OpenVidu::Session.new(server,
  customSessionId: 'your-custom-session-id',
  defaultOutputMode: 'INDIVIDUAL',
  recordingMode: 'ALWAYS').create

# Create a token to publish video
token = OpenVidu::Token.new(server, session: 'your-custom-session-id,
  role: "PUBLISHER",
  data: {
    "full_name": "John Smith"  # Custom data can be supplied here
  }
)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BryanSaxon/open_vidu. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OpenVidu project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/open_vidu/blob/master/CODE_OF_CONDUCT.md).
