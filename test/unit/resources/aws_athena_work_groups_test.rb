require 'helper'
require 'aws_athena_work_groups'
require 'aws-sdk-core'

class AWSAthenaWorkGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSAthenaWorkGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSAthenaWorkGroups.new('rubbish') }
  end

  def test_work_groups_non_existing_for_empty_response
    refute AWSAthenaWorkGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSAthenaWorkGroupsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_work_groups
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:description] = 'test1'
    data[:data] = { :work_groups => [mock_data] }
    data[:client] = Aws::Athena::Client
    @work_group = AWSAthenaWorkGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_work_groups_exists
    assert @work_group.exist?
  end

  def test_names
    assert_equal(@work_group.names, ['test1'])
  end

  def test_states
    assert_equal(@work_group.states, ['test1'])
  end

  def test_descriptions
    assert_equal(@work_group.descriptions, ['test1'])
  end
end