# frozen_string_literal: true
require 'net/ssh'
require 'net/scp'

class SSHClient
  attr_reader :server, :client

  def initialize(server)
    @server = server
    @client = nil
  end

  def method_missing(command, *args)
    command_string = command.to_s
    if run("command -v #{command_string}")
      puts "Executing command: #{command} #{args.join(' ')}"
      output = run("#{command} #{args.join(' ')}")
      puts output
    else
      super
    end
  end

  def connect
    @client = Net::SSH.start(@server.host, @server.user, password: @server.password)
  rescue StandardError => e
    puts "Error connecting to #{@server.host}: #{e.message}"
  end

  def run1(command)
    return unless @client

    @client.exec!(command)
  rescue StandardError => e
    puts "Error executing command on #{@host}: #{e.message}"
    nil
  end

  def run(command)
    connect unless @client
    output = ""
    @client.exec!(command) do |channel, stream, data|
      output = data
    end
    output
  end

  def put(local_file, remote_path)
    connect unless @client
    Net::SCP.upload!(@client.connection, local_file, remote_path)
  end

  def close
    @client.close if @client
  end
end
