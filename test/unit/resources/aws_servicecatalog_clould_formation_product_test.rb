require 'helper'
require 'aws_servicecatalog_cloud_formation_product'
require 'aws-sdk-core'

class AWSServiceCatalogCloudFormationProductConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogCloudFormationProduct.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSServiceCatalogCloudFormationProduct.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSServiceCatalogCloudFormationProduct.new(unexpected: 9) }
  end
end

class AWSServiceCatalogCloudFormationProductSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_product_as_admin
    mock_data = {}
    mock_data[:product_view_detail] = {}
    mock_data[:provisioning_artifact_summaries] = []
    mock_data[:tags] = []
    mock_data[:tag_options] = []
    mock_data[:budgets] = []
    data[:data] = [mock_data]
    data[:client] = Aws::ServiceCatalog::Client
    @resp = AWSServiceCatalogCloudFormationProduct.new(name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_product_exists
    assert @resp.exists?
  end

  def test_product_view_detail
    assert_equal(@resp.product_view_detail, {})
  end

  def test_provisioning_artifact_summaries
    assert_equal(@resp.provisioning_artifact_summaries, [])
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end

  def test_tag_options
    assert_equal(@resp.tag_options, [])
  end

  def test_budgets
    assert_equal(@resp.budgets, [])
  end
end