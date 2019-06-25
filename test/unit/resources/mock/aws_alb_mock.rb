require_relative 'aws_base_resource_mock'

class AwsAlbMock < AwsBaseResourceMock

  def initialize
    super
    @alb = {load_balancers: [{load_balancer_arn: @aws.any_arn,
                            load_balancer_name: @aws.any_string,
                            availability_zones: [{:zone_name=>"eu-central-1b", :subnet_id=>"subnet-05fa0af06ffd2e2e4", :load_balancer_addresses=>[{:ip_address=> 'test', :allocation_id=> 'testid'}]}],
                            canonical_hosted_zone_id: @aws.any_string,
                            dns_name: @aws.any_string,
                            scheme: @aws.any_string,
                            state: {:code=>'active', :reason=>'reason'},
                            security_groups: ["sg-0be56ecc61ff32fc7"],
                            type: @aws.any_string,
                            vpc_id: @aws.any_string,
                            created_time: Time.now }]}
  end

  def stub_data
    stub_data = []
    alb = {:client => Aws::ElasticLoadBalancingV2::Client,
              :method => :describe_load_balancers,
              :data => @alb}

    stub_data += [alb]
  end

  def alb
    @alb
  end
end