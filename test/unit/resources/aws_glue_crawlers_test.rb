require 'helper'
require 'aws_glue_crawlers'
require 'aws-sdk-core'

class AWSGlueCrawlersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSGlueCrawlers.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSGlueCrawlers.new('rubbish') }
  end

  def test_crawlers_non_existing_for_empty_response
    refute AWSGlueCrawlers.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSGlueCrawlersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_crawlers
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:role] = 'test1'
    mock_data[:database_name] = 'test1'
    data[:data] = { :crawlers => [mock_data] }
    data[:client] = Aws::Glue::Client
    @crawlers = AWSGlueCrawlers.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_crawlers_exists
    assert @crawlers.exist?
  end

  def test_names
    assert_equal(@crawlers.names, ['test1'])
  end

  def test_roles
    assert_equal(@crawlers.roles, ['test1'])
  end

  def test_database_names
    assert_equal(@crawlers.database_names, ['test1'])
  end
end