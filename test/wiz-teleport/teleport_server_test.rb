require_relative '../test_helper'

class TeleportServerTest < Minitest::Test
  def setup
    @options = {
      name: 'Test Server',
      host: '192.168.1.1',
      user: 'admin',
      password: 'password123',
      port: 22
    }
    @server = WizTeleport::Server.new(@options)
  end

  def test_initialization
    assert_equal 'Test Server', @server.name
    assert_equal '192.168.1.1', @server.host
    assert_equal 'admin', @server.user
    assert_equal 'password123', @server.password
    assert_equal 22, @server.port
  end

  def test_to_h
    expected_hash = {
      'host' => '192.168.1.1',
      'name' => 'Test Server',
      'user' => 'admin',
      'password' => 'password123',
      'port' => 22
    }
    assert_equal expected_hash, @server.to_h
  end

  def test_partial_options
    server = WizTeleport::Server.new(name: 'Another Server', host: '192.168.1.2')
    expected_hash = {
      'host' => '192.168.1.2',
      'name' => 'Another Server'
    }
    assert_equal expected_hash, server.to_h
  end

  def test_empty_initialization
    server = WizTeleport::Server.new({})
    assert_nil server.name
    assert_nil server.host
    assert_nil server.user
    assert_nil server.password
    assert_nil server.port
  end
end
