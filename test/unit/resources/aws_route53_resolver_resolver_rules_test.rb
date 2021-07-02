require 'helper'
require 'aws_route53resolver_resolver_rules'
require 'aws-sdk-core'

class AWSRoute53ResolverResolverRulesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSRoute53ResolverResolverRules.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRules.new('rubbish') }
  end

  def test_resolver_rules_non_existing_for_empty_response
    refute AWSRoute53ResolverResolverRules.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSRoute53ResolverResolverRulesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_resolver_rules
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
    data[:data] = { :resolver_rules => [mock_data] }
    data[:client] = Aws::Route53Resolver::Client
    @resolver_rules = AWSRoute53ResolverResolverRules.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resolver_rule_exists
    assert @resolver_rules.exists?
  end

  def test_ids
    assert_equal(@resolver_rules.ids, ['test1'])
  end

  def test_creator_request_ids
    assert_equal(@resolver_rules.creator_request_ids, ['test1'])
  end

  def test_arns
    assert_equal(@resolver_rules.arns, ['test1'])
  end

  def test_domain_names
    assert_equal(@resolver_rules.domain_names, ['test1'])
  end

  def test_statuses
    assert_equal(@resolver_rules.statuses, ['test1'])
  end

  def test_status_messages
    assert_equal(@resolver_rules.status_messages, ['test1'])
  end

  def test_rule_types
    assert_equal(@resolver_rules.rule_types, ['test1'])
  end

  def test_names
    assert_equal(@resolver_rules.names, ['test1'])
  end

  def test_target_ips
    assert_equal(@resolver_rules.target_ips, [[]])
  end

  def test_resolver_endpoint_ids
    assert_equal(@resolver_rules.resolver_endpoint_ids, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resolver_rules.owner_ids, ['test1'])
  end

  def test_share_statuses
    assert_equal(@resolver_rules.share_statuses, ['test1'])
  end

  def test_creation_times
    assert_equal(@resolver_rules.creation_times, ['test1'])
  end

  def test_modification_times
    assert_equal(@resolver_rules.modification_times, ['test1'])
  end
end