# frozen_string_literal: true

module DiscoLlama
  class Config
    DEFAULTS = {
      discord: {
        token: ENV["DISCORD_BOT_TOKEN"],
        app_id: ENV["DISCORD_APP_ID"],
        prefix: "/",
      },
      ollama: {
        base_uri: ENV["OLLAMA_BASE_URI"] || "http://localhost:11434/api",
      },
    }.freeze

    def self.default
      new(DEFAULTS)
    end

    Discord = Struct.new(:token, :app_id, :prefix, keyword_init: true)
    Ollama = Struct.new(:base_uri, keyword_init: true)

    attr_reader :discord, :ollama, :handlers

    def initialize(discord: {}, ollama: {})
      @discord = Discord.new(**discord)
      @ollama = Ollama.new(**ollama)
      @handlers = Hash.new { |h, k| h[k] = [] }
    end

    def on(event, &block)
      handlers[event] << block
    end

    def emit(event, *args)
      handlers[event].each { |block| block.call(*args) }
    end
  end

  module Configurable
    def config
      DiscoLlama.config
    end
  end
end
