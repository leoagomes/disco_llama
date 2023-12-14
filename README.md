# disco-llama

A LLM-based Discord bot, written in Ruby.

## Getting Started

### Installing

You'll need:

- Ruby `>= 3.2.2`
- [Ollama](https://ollama.ai) `>= 1.15`
- A discord bot token.

Run `bin/setup` to install Ruby dependencies. Install this gem onto your local
machine with `bundle exec rake install`.

### Usage

Write a configuration file in Ruby like the following (check `example_config.rb`
for more examples):

```ruby
DiscoLlama.configure do |config|
  config.discord.token = "YOUR DISCORD TOKEN"
  # change your Ollama instance URI with the following
  # config.ollama.base_uri = "http://localhost:11434/api"

  config.on :bot_start do |bot|
    # register default commands on startup
    bot.register_commands!
  end
end
```

Then run the bot with `disco-llama start <path-to-your-config>`.
The discord bot invite URL will be printed out by the `start` command, you can
use it to add the bot to your server.

Then try `/chat`ting with your bot.

![Sky is Blue](docs/images/sky-is-blue.png)

## High-Level Roadmap

- [ ] support conversations via replies
- [ ]

## Development

`rake spec` runs the tests (not any rn, sorry).
`bin/console` runs an interactive prompt with the library loaded.

To release a new version:

1. Update the version number in `version.rb`
2. run `bundle exec rake release`

## Contributing

Bug reports and pull requests are welcome [on GitHub](https://github.com/leoagomes/disco_llama).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
