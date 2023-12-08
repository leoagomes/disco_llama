# frozen_string_literal: true

require_relative "disco_llama/version"
require_relative "disco_llama/ollama"
require_relative "disco_llama/cli"

module DiscoLlama
  class Error < StandardError; end
end
