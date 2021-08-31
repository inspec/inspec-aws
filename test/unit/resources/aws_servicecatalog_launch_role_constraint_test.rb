require 'helper'
require 'aws_servicecatalog_launch_role_constraint'
require 'aws-sdk-core'

class AWSServiceCatalogLaunchRoleConstraintConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogLaunchRoleConstraint.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogLaunchRoleConstraint.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSServiceCatalogLaunchRoleConstraint.new(unexpected: 9) }
  end
end

class AWSServiceCatalogLaunchRoleConstraintSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_constraint
    mock_data = {}
    mock_data[:constraint_detail] = {}
    mock_data[:constraint_parameters] = 'test1'
    mock_data[:status] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::ServiceCatalog::Client
    @resp = AWSServiceCatalogLaunchRoleConstraint.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_constraint_exists
    assert @resp.exists?
  end

  def test_constraint_detail
    assert_equal(@resp.constraint_detail, {})
  end

  def test_constraint_parameters
    assert_equal(@resp.constraint_parameters, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end
end