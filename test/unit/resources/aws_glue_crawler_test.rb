require 'helper'
require 'aws_glue_crawler'
require 'aws-sdk-core'

class AWSGlueCrawlerConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSGlueCrawler.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSGlueCrawler.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSGlueCrawler.new(unexpected: 9) }
  end
end

class AWSGlueCrawlerSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_crawler
    mock_parameter = {}
    mock_parameter[:name] = 'test1'
    mock_parameter[:role] = 'test1'
    mock_parameter[:description] = 'test1'
    data[:data] = { crawler: mock_parameter }
    data[:client] = Aws::Glue::Client
    @crawler = AWSGlueCrawler.new(name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @crawler.exists?
  end

  def test_name
    assert_equal(@crawler.name, 'test1')
  end

  def test_role
    assert_equal(@crawler.role, 'test1')
  end

  def test_description
    assert_equal(@crawler.description, 'test1')
  end

  def test_resource_id
    refute_nil(@crawler.resource_id)
    assert_equal(@crawler.resource_id, 'test1')
  end
end