# frozen_string_literal: true

require "thor"

module DiscoLlama
  class CLI < Thor
    desc "start CONFIG", "runs the bot with a given config file"
    def start(config_path)
      load config_path
      bot = Discord::Bot.new
      puts "Starting bot..."
      puts "Invite URL: #{bot.discord.invite_url}"
      bot.run
    end
  end
end
