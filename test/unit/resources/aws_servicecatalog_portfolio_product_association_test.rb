require 'helper'
require 'aws_servicecatalog_portfolio_product_association'
require 'aws-sdk-core'

class AWSServiceCatalogPortfolioProductAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioProductAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioProductAssociation.new(product_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioProductAssociation.new(unexpected: 9) }
  end
end

class AWSServiceCatalogPortfolioProductAssociationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_portfolios_for_product
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:display_name] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:created_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:provider_name] = 'test1'
    data[:data] = {:portfolio_details => [mock_data] }
    data[:client] = Aws::ServiceCatalog::Client
    @portfolio_details = AWSServiceCatalogPortfolioProductAssociation.new(product_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_portfolio_details_exists
    assert @portfolio_details.exists?
  end

  def test_id
    assert_equal(@portfolio_details.id, 'test1')
  end

  def test_arn
    assert_equal(@portfolio_details.arn, 'test1')
  end

  def test_display_name
    assert_equal(@portfolio_details.display_name, 'test1')
  end

  def test_description
    assert_equal(@portfolio_details.description, 'test1')
  end

  def test_created_time
    assert_equal(@portfolio_details.created_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_provider_name
    assert_equal(@portfolio_details.provider_name, 'test1')
  end
end