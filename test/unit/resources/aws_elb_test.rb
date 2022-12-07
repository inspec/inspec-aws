require 'helper'
require 'aws-sdk-elasticloadbalancing'
require 'aws-sdk-core'
require 'aws_elb'

class AwsElbConstructorTest < Minitest::Test

  def setup
    @mock_elb = {}
    @mock_elb[:availability_zones] = ["eu-central-1a"]
    @mock_elb[:dns_name] = "rooty-tooty-elb.eu-central-1.elb.amazonaws.com"
    @mock_elb[:load_balancer_name] = 'rooty-tooty-pointy-shooty'
    @mock_elb[:listener_descriptions] = [
      {:listener=>{:protocol=>"HTTP", :load_balancer_port=>80, :instance_protocol=>"HTTP", :instance_port=>8000, :ssl_certificate_id=>nil}, :policy_names=>[]},
      {:listener=>{:protocol=>"HTTPS", :load_balancer_port=>443, :instance_protocol=>"HTTPS", :instance_port=>8443, :ssl_certificate_id=>'arn:aws:acm:eu-west-2:some_certificate'}, :policy_names=>['OurCustomPolicy']}
    ]
    @mock_elb[:instances] = [{:instance_id=>"i-0d2a0debb9f2a0183"}]
    @mock_elb[:security_groups] = ["sg-0850ba738e6e18520"]
    @mock_elb[:subnets] = ["subnet-87bdfeec"]
    @mock_elb[:vpc_id] = "vpc-807dfdeb"

    @mock_elb_policy = {}
    @mock_elb_policy[:policy_name] = "OurCustomPolicy"
    @mock_elb_policy[:policy_type_name] = "SSLNegotiationPolicyType"
    @mock_elb_policy[:policy_attribute_descriptions] = [
      {:attribute_name=> "Reference-Security-Policy", :attribute_value=>"ELBSecurityPolicy-2016-08"},
      {:attribute_name=>"Protocol-TLSv1", :attribute_value=>"true"},
      {:attribute_name=>"Protocol-SSLv3", :attribute_value=>"false"},
      {:attribute_name=>"Protocol-TLSv1.1", :attribute_value=>"true"},
      {:attribute_name=>"Protocol-TLSv1.2", :attribute_value=>"true"},
    ]

    stub_data = []
    elb = {:client => Aws::ElasticLoadBalancing::Client,
              :method => :describe_load_balancers,
              :data => { :load_balancer_descriptions => [@mock_elb] }}
    stub_data += [elb]

    elb_policy = {:client => Aws::ElasticLoadBalancing::Client,
      :method => :describe_load_balancer_policies,
      :data => { :policy_descriptions => [@mock_elb_policy] }}

    stub_data += [elb_policy]

    @elb = AwsElb.new(load_balancer_name: @mock_elb[:load_balancer_name],
                                 client_args: { stub_responses: true },
                                 stub_data: stub_data)
  end

  def test_resource_id
    refute_nil(@elb.resource_id)
    assert_equal(@elb.resource_id, "#{@mock_elb[:load_balancer_name]}_#{@mock_elb[:availability_zones]}")
  end

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsElb.new(client_args: { stub_responses: true }) }
  end

  def test_elb_name
    assert_equal(@elb.load_balancer_name, @mock_elb[:load_balancer_name])
  end

  def test_availability_zones
    assert_equal(@elb.availability_zones, @mock_elb[:availability_zones])
  end

  def test_dns_name
    assert_equal(@elb.dns_name, @mock_elb[:dns_name])
  end

  def test_external_ports
    assert_equal(@elb.external_ports, [80, 443])
  end

  def test_instance_ids
    assert_equal(@elb.instance_ids, ['i-0d2a0debb9f2a0183'])
  end

  def test_internal_ports
    assert_equal(@elb.internal_ports, [8000, 8443])
  end

  def test_security_group_ids
    assert_equal(@elb.security_group_ids, ['sg-0850ba738e6e18520'])
  end

  def test_subnet_ids
    assert_equal(@elb.subnet_ids, ["subnet-87bdfeec"])
  end

  def test_vpc_id
    assert_equal(@elb.vpc_id, "vpc-807dfdeb")
  end

  def test_ssl_policies
    assert_equal(@elb.ssl_policies.first.policy_name, 'OurCustomPolicy')
    assert_equal(@elb.ssl_policies.first.policy_attribute_descriptions.select { |a| a[:attribute_name] == 'Reference-Security-Policy'}.first.attribute_value, 'ELBSecurityPolicy-2016-08')
    assert_equal(@elb.ssl_policies.first.policy_attribute_descriptions.select { |a| a[:attribute_name] == 'Protocol-SSLv3'}.first.attribute_value, "false")
  end

  def test_protocols
    assert_equal(@elb.protocols, ['HTTP', 'HTTPS'])
  end

  def test_exists
    assert @elb.exists?
  end
end
