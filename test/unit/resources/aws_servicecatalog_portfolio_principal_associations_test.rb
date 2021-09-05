require 'helper'
require 'aws_servicecatalog_portfolio_principal_associations'
require 'aws-sdk-core'

class AWSServiceCatalogPortfolioPrincipalAssociationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSServiceCatalogPortfolioPrincipalAssociations.new(portfolio_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioPrincipalAssociations.new('rubbish') }
  end

  def test_principals_non_existing_for_empty_response
    refute AWSServiceCatalogPortfolioPrincipalAssociations.new(portfolio_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSServiceCatalogPortfolioPrincipalAssociationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_principals_for_portfolio
    mock_data = {}
    mock_data[:principal_arn] = 'test1'
    mock_data[:principal_type] = 'test1'
    data[:data] = { :principals => [mock_data] }
    data[:client] = Aws::ServiceCatalog::Client
    @principals = AWSServiceCatalogPortfolioPrincipalAssociations.new(portfolio_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_principals_exists
    assert @principals.exist?
  end

  def test_principal_arns
    assert_equal(@principals.principal_arns, ['test1'])
  end

  def test_principal_types
    assert_equal(@principals.principal_types, ['test1'])
  end
end