# frozen_string_literal: true

require_relative "base"

module DiscoLlama
  module Discord
    module Commands
      class Chat < Base
        def command = :chat

        def call(event, *)
          prompt = extract_prompt(event.message)
          message = event.message.reply!("Thinking 🤔...", mention_user: true)
          stream_response_edits(prompt, message)
          message.create_reaction("🔄")
        end

        private

        def extract_prompt(message)
          message.content.sub(/^#{DiscoLlama.config.discord.prefix}#{command}\s+/, "")
        end

        def stream_response_edits(prompt, message, throttle: 20)
          response_count = 0

          final = Ollama.client.generate_stream(model: "llama2-uncensored", prompt:) do |response|
            response_count += 1

            message.edit(response.partial_response + response.response) if (response_count % throttle).zero?
          end

          message.edit(final.partial_response + final.response)
        end
      end
    end
  end
end
