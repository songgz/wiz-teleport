# frozen_string_literal: true
require 'rake'
require_relative './shell'

module WizTeleport
  module RakeDSL

    def shell(task_name, group_name, &block)
      Rake::Task.define_task(task_name) do
        WizTeleport::Shell.run(group_name, &block) if block_given?
      end
    end

  end
end

# Rake::TaskManager.record_task_metadata do |t|
#   t.instance_eval do
#     extend Teleport::RakeDSL
#   end
# end
# if defined?(Rake)
#   Rake.application.instance_eval do
#     extend Teleport::RakeDSL
#   end
# end
