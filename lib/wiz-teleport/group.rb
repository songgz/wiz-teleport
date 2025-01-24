# frozen_string_literal: true
require_relative './server'

module WizTeleport
  class Group
    attr_reader :name, :servers, :children, :user, :password, :port

    def initialize(options = {})
      options = options.transform_keys(&:to_sym)
      @name = options[:name]
      @children = options[:children] || []
      @user = options[:user] || 'root'
      @password = options[:password]
      @port = options[:port] || 22
      @servers = (options[:servers] || []).map do |server_data|
        server_data[:user] ||= @user
        server_data[:password] ||= @password
        server_data[:port] ||= @port
        Server.new(server_data)
      end
    end

    def to_h
      h = {'name' => @name}
      h['servers'] = @servers.map(&:to_h)
      h['children'] = @children if @children
      h['user'] = @user if @user
      h['password'] = @password if @password
      h['port'] = @port if @port
      h
    end
  end
end

