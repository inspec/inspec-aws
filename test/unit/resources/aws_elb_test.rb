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
    @mock_elb[:listener_descriptions] = [{:listener=>{:protocol=>"HTTP", :load_balancer_port=>80, :instance_protocol=>"HTTP", :instance_port=>8000, :ssl_certificate_id=>nil}, :policy_names=>[]}]
    @mock_elb[:instances] = [{:instance_id=>"i-0d2a0debb9f2a0183"}]
    @mock_elb[:security_groups] = ["sg-0850ba738e6e18520"]
    @mock_elb[:subnets] = ["subnet-87bdfeec"]
    @mock_elb[:vpc_id] = "vpc-807dfdeb"

    stub_data = {}
    stub_data[:method] = :describe_load_balancers
    stub_data[:data]   = { :load_balancer_descriptions => [@mock_elb] }
    stub_data[:client] = Aws::ElasticLoadBalancing::Client

    @elb = AwsElb.new(load_balancer_name: @mock_elb[:load_balancer_name],
                                 client_args: { stub_responses: true },
                                 stub_data: [stub_data])
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
    assert_equal(@elb.external_ports, [80])
  end

  def test_instance_ids
    assert_equal(@elb.instance_ids, ['i-0d2a0debb9f2a0183'])
  end

  def test_internal_ports
    assert_equal(@elb.internal_ports, [8000])
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

  def test_exists
    assert @elb.exists?
  end
end