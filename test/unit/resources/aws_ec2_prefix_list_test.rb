require 'helper'
require 'aws_ec2_prefix_list'
require 'aws-sdk-core'

class AWSEC2PrefixListConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2PrefixList.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2PrefixList.new(global_network_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2PrefixList.new(unexpected: 9) }
  end
end

class AWSEC2PrefixListSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_managed_prefix_lists
    mock_data = {}
    mock_data[:prefix_list_id] = 'test1'
    mock_data[:address_family] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:state_message] = 'test1'
    mock_data[:prefix_list_arn] = 'test1'
    mock_data[:prefix_list_name] = 'test1'
    mock_data[:max_entries] = 1
    mock_data[:version] = 1
    mock_data[:owner_id] = 'test1'
    data[:data] = { prefix_lists: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2PrefixList.new(prefix_list_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_prefix_lists_exists
    assert @resp.exists?
  end

  def test_prefix_list_id
    assert_equal(@resp.prefix_list_id, 'test1')
  end

  def test_address_family
    assert_equal(@resp.address_family, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_state_message
    assert_equal(@resp.state_message, 'test1')
  end

  def test_prefix_list_arn
    assert_equal(@resp.prefix_list_arn, 'test1')
  end

  def test_prefix_list_name
    assert_equal(@resp.prefix_list_name, 'test1')
  end

  def test_max_entries
    assert_equal(@resp.max_entries, 1 )
  end

  def test_version
    assert_equal(@resp.version, 1)
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end
end