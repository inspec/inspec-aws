require 'helper'
require 'aws_servicecatalog_portfolio_principal_association'
require 'aws-sdk-core'

class AWSServiceCatalogPortfolioPrincipalAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioPrincipalAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioPrincipalAssociation.new(portfolio_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioPrincipalAssociation.new(unexpected: 9) }
  end
end

class AWSServiceCatalogPortfolioPrincipalAssociationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_principals_for_portfolio
    mock_data = {}
    mock_data[:principal_arn] = 'test1'
    mock_data[:principal_type] = 'test1'
    data[:data] = {:principals => [mock_data] }
    data[:client] = Aws::ServiceCatalog::Client
    @principals = AWSServiceCatalogPortfolioPrincipalAssociation.new(portfolio_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_principals_exists
    assert @principals.exists?
  end

  def test_principal_arn
    assert_equal(@principals.principal_arn, 'test1')
  end

  def test_principal_type
    assert_equal(@principals.principal_type, 'test1')
  end
end