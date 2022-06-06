require 'helper'
require 'aws_api_gateway_vpc_links'
require 'aws-sdk-core'

class AWSApiGatewayVPCLinksConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayVPCLinks.new(unexpected: 9) }
  end
end

class AWSApiGatewayVPCLinksSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_vpc_links
    mock_data = {}
    mock_data[:id] = 'test'
    mock_data[:name] = 'test'
    mock_data[:description] = 'test'
    mock_data[:target_arns] = ['test']
    mock_data[:status] = 'test'
    mock_data[:status_message] = 'test'
    mock_data[:tags] = {}
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayVPCLinks.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpc_links_exists
    assert @res.exists?
  end

  def test_ids
    assert_equal(@res.ids, ['test'])
  end

  def test_names
    assert_equal(@res.names, ['test'])
  end

  def test_descriptions
    assert_equal(@res.descriptions, ['test'])
  end

  def test_target_arns
    assert_equal(@res.target_arns, ['test'])
  end

  def test_statuses
    assert_equal(@res.statuses, ['test'])
  end

  def test_status_messages
    assert_equal(@res.status_messages, ['test'])
  end

  def test_tags
    assert_equal(@res.tags, [{}])
  end
end