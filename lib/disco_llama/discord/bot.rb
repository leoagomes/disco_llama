# frozen_string_literal: true

require "discordrb"

require_relative "commands/hello"
require_relative "commands/chat"

module DiscoLlama
  module Discord
    class Bot
      include DiscoLlama::Configurable

      attr_reader :discord

      def initialize
        @discord = Discordrb::Commands::CommandBot.new(
          token: config.discord.token,
          prefix: config.discord.prefix
        )
      end

      def run
        config.emit(:bot_start, self)
        discord.run
      end

      def register_commands!
        discord.command(:hello, &Commands::Hello)
        discord.command(:chat, &Commands::Chat)
      end
    end
  end
end
