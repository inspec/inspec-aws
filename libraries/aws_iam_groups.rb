require "aws_backend"

class AwsIamGroups < AwsResourceBase
  name "aws_iam_groups"
  desc "Verifies settings for a collection AWS IAM Groups."
  example "
    describe aws_iam_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:group_names,  field: :group_name)
    .register_column(:group_ids,    field: :group_id)
    .register_column(:arns,         field: :arn)
    .register_column(:users,        field: :users)
    .register_column(:has_inline_policies,   field: :has_inline_policies)
    .register_column(:inline_policy_names,   field: :inline_policy_names)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    group_rows = []
    groups = {}
    pagination_options = {}

    loop do
      catch_aws_errors do
        groups = @aws.iam_client.list_groups(pagination_options)
        return [] if !groups || groups.empty?

        groups.groups.each do |g|
          inline_policies = @aws.iam_client.list_group_policies({ 'group_name': g.group_name }).policy_names
          group_rows += [{ group_name:          g.group_name,
                           group_id:            g.group_id,
                           arn:                 g.arn,
                           users:               @aws.iam_client.get_group({ 'group_name': g.group_name }).users.map(&:user_name),
                           has_inline_policies: !inline_policies.empty?,
                           inline_policy_names: inline_policies }]
        end
      end
      break unless groups.marker
      pagination_options = { marker: groups.marker }
    end
    @table = group_rows
  end
end
