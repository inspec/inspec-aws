require 'helper'
require 'aws_servicecatalog_launch_role_constraints'
require 'aws-sdk-core'

class AWSServiceCatalogLaunchRoleConstraintsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSServiceCatalogLaunchRoleConstraints.new(portfolio_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSServiceCatalogLaunchRoleConstraints.new('rubbish') }
  end

  def test_constraint_details_non_existing_for_empty_response
    refute AWSServiceCatalogLaunchRoleConstraints.new(portfolio_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSServiceCatalogLaunchRoleConstraintsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_constraints_for_portfolio
    mock_data = {}
    mock_data[:constraint_id] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:owner] = 'test1'
    mock_data[:product_id] = 'test1'
    mock_data[:portfolio_id] = 'test1'
    data[:data] = { :constraint_details => [mock_data] }
    data[:client] = Aws::ServiceCatalog::Client
    @constraint_details = AWSServiceCatalogLaunchRoleConstraints.new(portfolio_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_constraint_details_exists
    assert @constraint_details.exist?
  end

  def test_constraint_ids
    assert_equal(@constraint_details.constraint_ids, ['test1'])
  end

  def test_types
    assert_equal(@constraint_details.types, ['test1'])
  end

  def test_descriptions
    assert_equal(@constraint_details.descriptions, ['test1'])
  end

  def test_owners
    assert_equal(@constraint_details.owners, ['test1'])
  end

  def test_product_ids
    assert_equal(@constraint_details.product_ids, ['test1'])
  end

  def test_portfolio_ids
    assert_equal(@constraint_details.portfolio_ids, ['test1'])
  end
end