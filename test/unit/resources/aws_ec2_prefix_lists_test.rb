require 'helper'
require 'aws_ec2_prefix_lists'
require 'aws-sdk-core'

class AWSEC2PrefixListsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2PrefixLists.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2PrefixLists.new('rubbish') }
  end

  def test_prefix_lists_non_existing_for_empty_response
    refute AWSEC2PrefixLists.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2PrefixListsHappyPathTest < Minitest::Test

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
    data[:data] = { :prefix_lists => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2PrefixLists.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_prefix_list_ids
    assert_equal(@resp.prefix_list_ids, ['test1'])
  end

  def test_address_families
    assert_equal(@resp.address_families, ['test1'])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_state_messages
    assert_equal(@resp.state_messages, ['test1'])
  end

  def test_prefix_list_arns
    assert_equal(@resp.prefix_list_arns, ['test1'])
  end

  def test_prefix_list_names
    assert_equal(@resp.prefix_list_names, ['test1'])
  end

  def test_max_entries
    assert_equal(@resp.max_entries, [1])
  end

  def test_versions
    assert_equal(@resp.versions, [1])
  end
end