require_relative 'aws_base_resource_mock'

class AwsNetworkACLMock < AwsBaseResourceMock
  attr_reader :vpc_id, :network_acl_id, :tags, :is_default, :association, :ingress, :egress,
              :associated_subnet_id, :cidr_block, :network_acl_association_id

  def initialize
    super
    @network_acl_id = 'acl-5fb85d36'
    @tags = []
    @is_default = false
    @vpc_id = 'vpc-a01106c2'
    @associated_subnet_id = 'subnet-65ea5f08'
    @cidr_block = '0.0.0.0/0'
    @network_acl_association_id = 'aclassoc-66ea5f0b'
    @association = {
      network_acl_association_id: network_acl_association_id,
      network_acl_id: 'acl-9aeb5ef7',
      subnet_id: 'subnet-65ea5f08',
    }
    @ingress = {
      cidr_block: cidr_block,
      egress: true,
      protocol: '-1',
      rule_action: 'deny',
      rule_number: 32767,
    }
    @egress = {
      cidr_block: cidr_block,
      egress: false,
      protocol: '-1',
      rule_action: 'deny',
      rule_number: 32767,
      port_range: {
        from: 80,
        to: 80,
      },
    }
    @network_acl = {
      network_acls: [
        {
          associations: [association],
          entries: [ingress, egress],
          is_default: is_default,
          network_acl_id: network_acl_id,
          tags: tags,
          vpc_id: vpc_id,
        },
      ],
    }
  end

  def stub_data
    {
      method: :describe_network_acls,
      client: Aws::EC2::Client,
      data: @network_acl,
    }
  end

  def multiple_stub_data(num = 2)
    {
      method: :describe_network_acls,
      client: Aws::EC2::Client,
      data: network_acl_collection(num),
    }
  end

  def network_acl_collection(num)
    num.times.map { @network_acl }
  end
end
