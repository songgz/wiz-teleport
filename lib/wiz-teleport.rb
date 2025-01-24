# frozen_string_literal: true
require_relative "wiz-teleport/version"
require_relative 'wiz-teleport/rake_dsl'

module WizTeleport
  class Error < StandardError; end
  # Your code goes here...
end


if defined?(Rake)
  extend WizTeleport::RakeDSL
end

# if defined?(Rake)
#   Rake.application.instance_eval do
#     extend Teleport::RakeDSL
#   end
# end