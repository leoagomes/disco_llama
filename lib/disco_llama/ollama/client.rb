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

      def initialize; end

      def generate(model:, prompt:, context: nil, format: nil, options: {})
        response =
          self.class.post(
            "/generate",
            body: { model:, prompt:, context:, format:, options:, stream: false }.to_json
          )
        hash_to_response!(response.parsed_response)
      end

      def generate_stream(model:, prompt:, context: nil, format: nil, options: {}) # rubocop:disable Metrics/MethodLength
        complete_response = StringIO.new
        final_response = Response.new(model:, response: "", done: true, created_at: DateTime.now)

        self.class.post(
          "/generate",
          body: { model:, prompt:, context:, format:, options:, stream: true }.to_json,
          stream_body: true
        ) do |fragment|
          response = fragment_to_response!(
            fragment,
            partial_response: complete_response.string
          )

          complete_response << response.response
          final_response = response.dup if response.done

          yield response
        end

        final_response
      end

      def embeddings(model:, prompt:, options: {})
        response =
          self.class.post(
            "/embeddings",
            body: { model:, prompt:, options: }.to_json
          )
        response.parsed_response["embeddings"]
      end

      private

      def fragment_to_response!(fragment, partial_response:)
        parsed = JSON.parse(fragment, symbolize_names: true)
        hash_to_response!(parsed, partial_response:)
      end

      def hash_to_response!(raw, partial_response:)
        result = Response::Schema.call(raw)
        raise "Invalid response: #{result.errors.to_h}" unless result.success?

        Response.new(result.to_h.merge(partial_response:))
      end
    end
  end
end
