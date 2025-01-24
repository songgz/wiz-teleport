# frozen_string_literal: true

require_relative "lib/wiz-teleport/version"

Gem::Specification.new do |spec|
  spec.name = "wiz-teleport"
  spec.version = WizTeleport::VERSION
  spec.authors = ["songgz"]
  spec.email = ["'sgzhe@163.com'"]

  spec.summary = "Teleport is a Ruby Gem that simplifies SSH connections and remote command execution. It is ideal for operational tasks and automated deployments."
  spec.description = "Teleport is designed to execute shell commands remotely over SSH, with no agents to install on remote systems."
  spec.homepage = "https://github.com/songgz/teleport"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/songgz/teleport/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "net-ssh", "~> 7.3.0"
  spec.add_dependency "net-scp", "~> 4.0.0"
  spec.add_dependency "rake", "~> 13.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
