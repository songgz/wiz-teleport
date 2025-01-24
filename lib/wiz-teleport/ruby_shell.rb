# frozen_string_literal: true
require_relative './inventory'

module WizTeleport
  class RubyShell
    def initialize(file_path = 'inventory.yml')
      @inventory = WizTeleport::Inventory.instance
      @inventory.from_yaml(file_path)
    end

    def run(group_name, &block)
      @clients = @inventory.clients_from_group(group_name)
      @clients.each do |client|
        client.instance_eval(&block)
      end
    end

    def self.run(group_name, &block)
      shell = WizTeleport::RubyShell.new
      shell.run(group_name, &block)
    end
  end
end



