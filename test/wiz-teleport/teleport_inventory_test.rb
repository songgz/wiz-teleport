require_relative '../test_helper'

class TeleportInventoryTest < Minitest::Test
  def setup
    @group = WizTeleport::Group.new(
      name: 'Test Group',
      user: 'admin',
      password: 'admin_password',
      port: 2222,
      servers: [
        { name: 'Server 1', host: '192.168.1.10' },
        { name: 'Server 2', host: '192.168.1.20' }
      ],
      children: []
    )

    @inventory = WizTeleport::Inventory.instance
    @inventory.add_host_group(@group)
  end

  def test_add_host_group
    assert_includes @inventory.groups, @group
  end

  def test_find_group_by_name
    found_group = @inventory.find_group_by_name('Test Group')
    assert_equal @group, found_group
  end

  def test_find_group_by_invalid_name
    found_group = @inventory.find_group_by_name('Invalid Group')
    assert_nil found_group
  end

  def test_find_groups_by_names
    found_groups = @inventory.find_groups_by_names(['Test Group'])
    assert_includes found_groups, @group
  end

  def test_clients_from_group_method
    clients = @inventory.clients_from_group('Test Group')

    assert_equal 2, clients.size
    server1 = clients[0].server
    server2 = clients[1].server


    assert_equal 'admin', server1.user  # Should use group user
    assert_equal 'admin_password', server1.password  # Should use group password
    assert_equal 2222, server1.port  # Should use group port

    assert_equal 'admin', server2.user
    assert_equal 'admin_password', server2.password
    assert_equal 2222, server2.port
  end

  def test_to_yaml
    yaml_file = 'test_inventory.yml'

    @inventory.to_yaml(yaml_file)
    yaml_content = File.read(yaml_file)

    assert_match /Test Group/, yaml_content
    File.delete(yaml_file)  # Clean up after test
  end

  def test_from_yaml
    yaml_file = 'test_inventory.yml'
    @inventory.to_yaml(yaml_file)

    new_inventory = WizTeleport::Inventory.instance
    new_inventory.from_yaml(yaml_file)

    assert_includes new_inventory.groups.map(&:name), @group.name
    File.delete(yaml_file)  # Clean up after test
  end

  def teardown
    @inventory.clear
    @group = nil
  end
end
