# frozen_string_literal: true

require_relative "ollama/client"

module DiscoLlama
  module Ollama
    class << self
      def client
        @client ||= Client.new
      end
    end
  end
end
