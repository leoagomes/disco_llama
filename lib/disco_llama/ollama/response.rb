# frozen_string_literal: true

require "dry/schema"
require "dry/struct"

require_relative "types"

module DiscoLlama
  module Ollama
    class Response < Dry::Struct
      attribute :model, Types::String
      attribute :created_at, Types::DateTime
      attribute :response, Types::String
      attribute :done, Types::Bool

      # time spent generating the response
      attribute? :total_duration, Types::Integer.optional
      # time spent in nanoseconds loading the model
      attribute? :load_duration, Types::Integer.optional
      # number of samples generated
      attribute? :sample_count, Types::Integer.optional
      # time spent generating samples
      attribute? :sample_duration, Types::Integer.optional
      # number of tokens in the prompt
      attribute? :prompt_eval_count, Types::Integer.optional
      # time spent in nanoseconds evaluating the prompt
      attribute? :prompt_eval_duration, Types::Integer.optional
      # number of tokens the response
      attribute? :eval_count, Types::Integer.optional
      # time in nanoseconds spent generating the response
      attribute? :eval_duration, Types::Integer.optional
      # an encoding of the conversation used in this response, this can be sent
      # in the next request to keep a conversational memory
      attribute? :context, Types::Array.of(Types::Integer).optional

      Schema = Dry::Schema.JSON do
        required(:model).filled(:string)
        required(:created_at).filled(:date_time)
        required(:response).maybe(:string)
        required(:done).filled(:bool)

        optional(:total_duration).filled(:integer)
        optional(:load_duration).filled(:integer)
        optional(:sample_count).filled(:integer)
        optional(:sample_duration).filled(:integer)
        optional(:prompt_eval_count).filled(:integer)
        optional(:prompt_eval_duration).filled(:integer)
        optional(:eval_count).filled(:integer)
        optional(:eval_duration).filled(:integer)
        optional(:context).array(:integer)
      end
    end
  end
end
