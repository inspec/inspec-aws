require 'helper'
require 'aws_route53resolver_resolver_rule_associations'
require 'aws-sdk-core'

class AWSRoute53ResolverResolverRuleAssociationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSRoute53ResolverResolverRuleAssociations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRuleAssociations.new('rubbish') }
  end

  def test_resolver_rule_associations_non_existing_for_empty_response
    refute AWSRoute53ResolverResolverRuleAssociations.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSRoute53ResolverResolverRuleAssociationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_resolver_rule_associations
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:resolver_rule_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:vpc_id] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:status_message] = 'test1'
    data[:data] = { :resolver_rule_associations => [mock_data] }
    data[:client] = Aws::Route53Resolver::Client
    @resolver_rule_associations = AWSRoute53ResolverResolverRuleAssociations.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resolver_rule_association_exists
    assert @resolver_rule_associations.exists?
  end

  def test_ids
    assert_equal(@resolver_rule_associations.ids, ['test1'])
  end

  def test_resolver_rule_ids
    assert_equal(@resolver_rule_associations.resolver_rule_ids, ['test1'])
  end

  def test_names
    assert_equal(@resolver_rule_associations.names, ['test1'])
  end

  def test_vpc_ids
    assert_equal(@resolver_rule_associations.vpc_ids, ['test1'])
  end

  def test_statuses
    assert_equal(@resolver_rule_associations.statuses, ['test1'])
  end

  def test_status_messages
    assert_equal(@resolver_rule_associations.status_messages, ['test1'])
  end
end