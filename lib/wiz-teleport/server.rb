# frozen_string_literal: true
module WizTeleport
  class Server
    attr_reader :host, :name
    attr_accessor :user, :password, :port

    def initialize(options)
      options = options.transform_keys(&:to_sym)
      @name = options[:name]
      @host = options[:host]
      @user = options[:user]
      @password = options[:password]
      @port = options[:port]
    end

    def to_h
      h = {'host' => @host}
      h['name'] = @name if @name
      h['user'] = @user if @user
      h['password'] = @password if @password
      h['port'] = @port if @port
      h
    end

  end
end


