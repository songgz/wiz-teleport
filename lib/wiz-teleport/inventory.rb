# frozen_string_literal: true
require 'yaml'
require 'singleton'
require_relative './group'
require_relative './server'
require_relative './ssh_client'

module WizTeleport
  class Inventory
    include Singleton
    attr_reader :groups

    def initialize
      @groups = []
    end

    def add_host_group(group)
      @groups.push(group)
    end

    def find_group_by_name(name)
      @groups.detect {|group| name == group.name}
    end

    def find_groups_by_names(names)
      @groups.select {|group| names.include?(group.name)}
    end

    def clients_from_group(group_name)
      group = @groups.find { |g| g.name == group_name }
      groups = group ? find_groups_by_names([group_name] + group.children) : @groups

      groups.flat_map do |group|
        group.servers&.map do |server|
          server.user ||= group.user
          server.password = group.password
          server.port ||= group.port
          SSHClient.new(server)
        end || []
      end
    end

    def to_yaml(file_path = 'inventory.yml')
      yaml_data = @groups.map(&:to_h)
      File.write(file_path,  YAML.dump(yaml_data))
    end


    def from_yaml(file_path = 'inventory.yml')
      yaml_data = YAML.load_file(file_path)
      @groups = yaml_data.map { |group_data| Group.new(group_data) }
    end

    def clear
      @groups = []
    end

  end
end
