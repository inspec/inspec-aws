require 'helper'
require 'aws_route53resolver_resolver_rule_association'
require 'aws-sdk-core'

class AWSRoute53ResolverResolverRuleAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRuleAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRuleAssociation.new(resolver_rule_association_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverRuleAssociation.new(unexpected: 9) }
  end
end

class AWSRoute53ResolverResolverRuleAssociationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_resolver_rule_association
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:resolver_rule_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:vpc_id] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:status_message] = 'test1'
    data[:data] = { resolver_rule_association: mock_data }
    data[:client] = Aws::Route53Resolver::Client
    @resolver_rule_association = AWSRoute53ResolverResolverRuleAssociation.new(resolver_rule_association_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resolver_rule_association_exists
    assert @resolver_rule_association.exists?
  end

  def test_id
    assert_equal(@resolver_rule_association.id, 'test1')
  end

  def test_resolver_rule_id
    assert_equal(@resolver_rule_association.resolver_rule_id, 'test1')
  end

  def test_name
    assert_equal(@resolver_rule_association.name, 'test1')
  end

  def test_vpc_id
    assert_equal(@resolver_rule_association.vpc_id, 'test1')
  end

  def test_status
    assert_equal(@resolver_rule_association.status, 'test1')
  end

  def test_status_message
    assert_equal(@resolver_rule_association.status_message, 'test1')
  end
end