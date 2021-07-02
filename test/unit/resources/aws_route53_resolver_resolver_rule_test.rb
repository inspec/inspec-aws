require 'helper'
require 'aws_route53resolver_resolver_rule'
require 'aws-sdk-core'

class AWSRoute53ResolverResolverRuleConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRule.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRule.new(resolver_rule_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRule.new(unexpected: 9) }
  end
end

class AWSRoute53ResolverResolverRuleSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_resolver_rule
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:creator_request_id] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:domain_name] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:status_message] = 'test1'
    mock_data[:rule_type] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:target_ips] = []
    mock_data[:resolver_endpoint_id] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:share_status] = 'test1'
    mock_data[:creation_time] = 'test1'
    mock_data[:modification_time] = 'test1'
    data[:data] = { resolver_rule: mock_data }
    data[:client] = Aws::Route53Resolver::Client
    @resolver_rule = AWSRoute53ResolverResolverRule.new(resolver_rule_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resolver_rule_exists
    assert @resolver_rule.exists?
  end

  def test_id
    assert_equal(@resolver_rule.id, 'test1')
  end

  def test_creator_request_id
    assert_equal(@resolver_rule.creator_request_id, 'test1')
  end

  def test_arn
    assert_equal(@resolver_rule.arn, 'test1')
  end

  def test_domain_name
    assert_equal(@resolver_rule.domain_name, 'test1')
  end

  def test_status
    assert_equal(@resolver_rule.status, 'test1')
  end

  def test_status_message
    assert_equal(@resolver_rule.status_message, 'test1')
  end

  def test_rule_type
    assert_equal(@resolver_rule.rule_type, 'test1')
  end

  def test_name
    assert_equal(@resolver_rule.name, 'test1')
  end

  def test_target_ips
    assert_equal(@resolver_rule.target_ips, [])
  end

  def test_resolver_endpoint_id
    assert_equal(@resolver_rule.resolver_endpoint_id, 'test1')
  end

  def test_owner_id
    assert_equal(@resolver_rule.owner_id, 'test1')
  end

  def test_share_status
    assert_equal(@resolver_rule.share_status, 'test1')
  end

  def test_creation_time
    assert_equal(@resolver_rule.creation_time, 'test1')
  end

  def test_modification_time
    assert_equal(@resolver_rule.modification_time, 'test1')
  end
end