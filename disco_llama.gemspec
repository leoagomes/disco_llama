# frozen_string_literal: true

require_relative "lib/disco_llama/version"

Gem::Specification.new do |spec|
  spec.name = "disco_llama"
  spec.version = DiscoLlama::VERSION
  spec.authors = ["Leonardo G."]
  spec.email = ["lgomes.leo@gmail.com"]

  spec.summary = "A llm-based discord bot."
  spec.description = "A llm-based discord bot that uses ollama for to interact with the user."
  spec.homepage = "https://github.com/leoagomes/disco_llama"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["allowed_push_host"] = "https://example.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/leoagomes/disco_llama"
  spec.metadata["changelog_uri"] = "https://github.com/leoagomes/disco_llama/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 7.1", ">= 7.1.2"
  spec.add_dependency "discordrb", "~> 3.5.0"
  spec.add_dependency "dotenv", "~> 2.8", ">= 2.8.1"
  spec.add_dependency "dry-schema", "~> 1.13", ">= 1.13.3"
  spec.add_dependency "dry-struct", "~> 1.6"
  spec.add_dependency "dry-types", "~> 1.7", ">= 1.7.1"
  spec.add_dependency "httparty", "~> 0.21.0"
  spec.add_dependency "rom", "~> 5.3"
  spec.add_dependency "rom-sql", "~> 3.6", ">= 3.6.1"
  spec.add_dependency "thor", "~> 1.3"
end
