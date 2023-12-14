# frozen_string_literal: true

require_relative "disco_llama/version"
require_relative "disco_llama/ollama"
require_relative "disco_llama/config"
require_relative "disco_llama/discord"

module DiscoLlama
  class Error < StandardError; end

  class << self
    def config
      @config ||= Config.new(**Config::DEFAULTS)
    end

    def configure
      yield(config)
    end
  end
end
