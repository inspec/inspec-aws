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
    @alb_listeners = {listeners: [{
                                    listener_arn: @aws.any_arn,
                                    load_balancer_arn: @aws.any_arn,
                                    port: 80,
                                    protocol: 'HTTP',
                                    certificates: [],
                                    ssl_policy: nil,
                                    default_actions: [],
                                  },
                                  {
                                    listener_arn: @aws.any_arn,
                                    load_balancer_arn: @aws.any_arn,
                                    port: 443,
                                    protocol: 'HTTPS',
                                    certificates: [{ certificate_arn: @aws.any_arn, is_default: nil }],
                                    ssl_policy: 'ELBSecurityPolicy-TLS-1-2-Ext-2018-06',
                                    default_actions: [] },
                                  ]}
  end

  def stub_data
    stub_data = []
    alb = {:client => Aws::ElasticLoadBalancingV2::Client,
              :method => :describe_load_balancers,
              :data => @alb}

    stub_data += [alb]

      ## Need to stub the AWS ALB class with listeners seperately (it's a second client method call to describe_listeners)
    alb_listeners = {:client => Aws::ElasticLoadBalancingV2::Client,
              :method => :describe_listeners,
              :data => @alb_listeners}

    stub_data += [alb_listeners]
  end

  def alb
    @alb
  end

  def alb_listeners
    @alb_listeners
  end
end
