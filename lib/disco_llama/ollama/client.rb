# frozen_string_literal: true

require "active_support/core_ext/hash/indifferent_access"
require "httparty"

require_relative "response"

module DiscoLlama
  module Ollama
    class Client
      include HTTParty

      base_uri ENV["OLLAMA_API_BASE_URI"] || "http://localhost:11434/api"
      headers "Content-Type" => "application/json"
      # debug_output

      def initialize; end

      def generate(model:, prompt:, format: nil, options: {})
        response =
          self.class.post(
            "/generate",
            body: { model:, prompt:, format:, options:, stream: false }.to_json
          )
        hash_to_response!(response.parsed_response)
      end

      def generate_stream(model:, prompt:, format: nil, options: {}) # rubocop:disable Metrics/MethodLength
        complete_response = StringIO.new
        final_response = Response.new(model:, response: "", done: true)

        self.class.post(
          "/generate",
          body: { model:, prompt:, format:, options:, stream: true }.to_json,
          stream_body: true
        ) do |fragment|
          parsed = JSON.parse(fragment, symbolize_names: true)
          response = hash_to_response!(parsed)

          complete_response << response.response
          final_response = response.dup if response.done

          yield response
        end

        final_response.response = complete_response.string
        final_response
      end

      private

      def hash_to_response!(raw)
        result = Response::Schema.call(raw)
        raise "Invalid response: #{result.errors.to_h}" unless result.success?

        Response.new(result.to_h)
      end
    end
  end
end
