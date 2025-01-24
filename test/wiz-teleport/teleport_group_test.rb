require_relative '../test_helper'

class TeleportGroupTest < Minitest::Test
  def setup
    @options = {
      name: 'Test Group',
      user: 'admin',
      password: 'admin_password',
      port: 2222,
      servers: [
        { name: 'Server 1', host: '192.168.1.10' },
        { name: 'Server 2', host: '192.168.1.20' }
      ],
      children: ['Child Group A', 'Child Group B']
    }
    @group = WizTeleport::Group.new(@options)
  end

  def test_initialization
    assert_equal 'Test Group', @group.name
    assert_equal 'admin', @group.user
    assert_equal 'admin_password', @group.password
    assert_equal 2222, @group.port
    assert_equal 2, @group.servers.size
  end

  def test_servers_initialization
    server1 = @group.servers[0]
    server2 = @group.servers[1]

    assert_equal 'Server 1', server1.name
    assert_equal '192.168.1.10', server1.host
    assert_equal 'admin', server1.user
    assert_equal 'admin_password', server1.password
    assert_equal 2222, server1.port

    assert_equal 'Server 2', server2.name
    assert_equal '192.168.1.20', server2.host
    assert_equal 'admin', server2.user
    assert_equal 'admin_password', server2.password
    assert_equal 2222, server2.port
  end

  def test_to_h
    expected_hash = {
      'name' => 'Test Group',
      'servers' => [
        { 'host' => '192.168.1.10', 'name' => 'Server 1', 'user' => 'admin', 'password' => 'admin_password', 'port' => 2222 },
        { 'host' => '192.168.1.20', 'name' => 'Server 2', 'user' => 'admin', 'password' => 'admin_password', 'port' => 2222 }
      ],
      'children' => ['Child Group A', 'Child Group B'],
      'user' => 'admin',
      'password' => 'admin_password',
      'port' => 2222
    }

    assert_equal expected_hash, @group.to_h
  end

  def test_empty_initialization
    group = WizTeleport::Group.new
    assert_nil group.name
    assert_equal 'root', group.user
    assert_nil group.password
    assert_equal 22, group.port
    assert_empty group.servers
    assert_empty group.children
  end

  def test_partial_server_options
    group = WizTeleport::Group.new(servers: [{ name: 'Server 3', host: '192.168.2.30' }])
    server = group.servers[0]

    assert_equal 'Server 3', server.name
    assert_equal '192.168.2.30', server.host
    assert_equal 'root', server.user  # Default user
    assert_nil server.password         # No password provided
    assert_equal 22, server.port       # Default port
  end
end
