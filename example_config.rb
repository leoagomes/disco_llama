# frozen_string_literal: true

DiscoLlama.configure do |config|
  # these are the default values for the config
  config.discord.token = ENV["DISCORD_BOT_TOKEN"]
  config.ollama.base_uri = ENV["OLLAMA_API_BASE_URI"] || "http://localhost:11434/api"

  config.on :bot_start do |bot|
    bot.register_commands!

    bot.discord.message do |event|
      binding.irb
    end

    nil
  end
end
