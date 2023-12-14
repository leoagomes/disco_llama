# frozen_string_literal: true

require_relative "base"

module DiscoLlama
  module Discord
    module Commands
      class Hello < Base
        def command = :hello

        def call(event, *)
          # event.send_message(
          #   "Hello, #{event.user.name}!",
          #   false,
          #   nil,
          #   nil,
          #   nil,
          #   event.message
          # )
          event.message.reply!(
            "Hello, #{event.user.name}!",
            mention_user: true
          )
        end
      end
    end
  end
end
