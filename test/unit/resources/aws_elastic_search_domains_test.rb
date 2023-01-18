require 'helper'
require 'aws_elasticsearchservice_domains'
require 'aws-sdk-core'

class AWSElasticSearchServiceDomainsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSElasticSearchServiceDomains.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSElasticSearchServiceDomains.new('rubbish') }
  end

  def test_domain_names_non_existing_for_empty_response
    refute AWSElasticSearchServiceDomains.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSElasticSearchServiceDomainsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_domain_names
    mock_data = {}
    mock_data[:domain_name] = 'test1'
    data[:data] = { :domain_names => [mock_data] }
    data[:client] = Aws::ElasticsearchService::Client
    @domains = AWSElasticSearchServiceDomains.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_domain_names_exists
    assert @domains.exist?
  end

  def test_domain_name
    assert_equal(@domains.domain_names, ['test1'])
  end
end