# frozen_string_literal: true

module DiscoLlama
  module Discord
    module Commands
      class Base
        def self.call(*args)
          new.call(*args)
        end

        def self.to_proc
          method(:call).to_proc
        end

        def call(*args)
          raise NotImplementedError
        end

        def to_proc
          method(:call).to_proc
        end

        def command
          raise NotImplementedError
        end
      end
    end
  end
end
