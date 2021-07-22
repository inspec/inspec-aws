require 'helper'
require 'aws_servicecatalog_portfolio_product_associations'
require 'aws-sdk-core'

class AWSServiceCatalogPortfolioProductAssociationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSServiceCatalogPortfolioProductAssociations.new(product_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSServiceCatalogPortfolioProductAssociations.new('rubbish') }
  end

  def test_portfolio_details_non_existing_for_empty_response
    refute AWSServiceCatalogPortfolioProductAssociations.new(product_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSServiceCatalogPortfolioProductAssociationsHappyPathTest < Minitest::Test

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
    data[:data] = { :portfolio_details => [mock_data] }
    data[:client] = Aws::ServiceCatalog::Client
    @portfolio_details = AWSServiceCatalogPortfolioProductAssociations.new(product_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_portfolio_exists
    assert @portfolio_details.exist?
  end

  def test_ids
    assert_equal(@portfolio_details.ids, ['test1'])
  end

  def test_arns
    assert_equal(@portfolio_details.arns, ['test1'])
  end

  def test_display_names
    assert_equal(@portfolio_details.display_names, ['test1'])
  end

  def test_descriptions
    assert_equal(@portfolio_details.descriptions, ['test1'])
  end

  def test_created_times
    assert_equal(@portfolio_details.created_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_provider_names
    assert_equal(@portfolio_details.provider_names, ['test1'])
  end
end