require 'helper'
require 'aws_elasticsearchservice_domain'
require 'aws-sdk-core'

class AWSElasticSearchServiceDomainConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticSearchServiceDomain.new(domain_name: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSElasticSearchServiceDomain.new(domain_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSElasticSearchServiceDomain.new(unexpected: 9) }
  end
end

class AWSElasticSearchServiceDomainSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_elasticsearch_domain
    mock_parameter = {}
    mock_parameter[:domain_id] = 'test1'
    mock_parameter[:processing] = true
    mock_parameter[:arn] = 'test1'
    mock_parameter[:domain_name] = 'test1'
    mock_parameter[:elasticsearch_cluster_config] = {}
    data[:data] = { domain_status: mock_parameter }
    data[:client] = Aws::ElasticsearchService::Client
    @domain_status = AWSElasticSearchServiceDomain.new(domain_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_domain_status_exists
    assert @domain_status.exists?
  end

  def test_domain_id
    assert_equal(@domain_status.domain_id, 'test1')
  end

  def test_processing
    assert_equal(@domain_status.processing, true)
  end

  def test_arn
    assert_equal(@domain_status.arn, 'test1')
  end

  def test_domain_name
    assert_equal(@domain_status.domain_name, 'test1')
  end

  def test_elasticsearch_cluster_config
    assert_equal(@domain_status.elasticsearch_cluster_config, {})
  end
end