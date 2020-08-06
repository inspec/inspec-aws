require_relative '../aws_base_resource_mock'

class AwsEksClusterMock < AwsBaseResourceMock

  def initialize
    super
    @eks = {}
    resources_vpc_config = {subnet_ids: [],
                            vpc_id: @aws.any_id,
                            security_group_ids: [] }

    attributes = { version: '1.11',
                   arn: @aws.any_arn,
                   certificate_authority: {},
                   name: "mock-cluster",
                   status: 'CREATING',
                   tags: {},
                   endpoint: @aws.any_string,
                   created_at: @aws.any_date,
                   role_arn: @aws.any_arn,
                   resources_vpc_config: resources_vpc_config,
                   logging: {:cluster_logging => [{:types => ["api", "audit", "authenticator", "controllerManager"], :enabled => false}, {:types => ["scheduler"], :enabled => true}]}
                  }
    @eks[:cluster] = attributes
  end

  def stub_data
    stub_data = []

    cluster = {:client => Aws::EKS::Client,
             :method => :describe_cluster,
             :data => @eks}

    stub_data += [cluster]
  end

  def eks
    @eks
  end
end
