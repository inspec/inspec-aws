require_relative '../aws_base_resource_mock'

class AwsIamGroupMock < AwsBaseResourceMock

  def initialize
    super
    @group = {}
    @group_required = {group_name: 'rooty-tooty-pointy-shooty',
                       group_id: "AGPAJNTWBNRUUY4MZC7P2",
                       arn: "arn:aws:iam::510367013858:group/compliance-scans",
                       create_date: Time.now.utc,
                       path: "/"}

    @users = [{path: "/",
               user_name: "rooty-tooty",
               user_id: "AAAAAAAABBBBBBBBBBBB1",
               arn: "arn:aws:iam::111111111111:user/arnold",
               password_last_used: nil,
               permissions_boundary: nil,
               create_date: Time.now.utc,
               tags: []}]
    @group[:group] = @group_required
    @group[:users] = @users
  end

  def stub_data
    stub_data = []

    group = {:client => Aws::IAM::Client,
             :method => :get_group,
             :data => @group}

    stub_data += [group]
  end

  def group
    @group
  end
end