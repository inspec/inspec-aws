require "aws_backend"

class AwsIamManagedPolicies < AwsResourceBase
  name "aws_iam_managed_policies"
  desc "Lists all IAM users, groups, and roles that the specified managed policy is attached to."

  example "
    describe aws_iam_managed_policies do
      it { should exist }
    end

    describe aws_iam_managed_policies(scope: 'SCOPE') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:arns, field: :arn)
    .register_column(:attachment_counts, field: :attachment_count)
    .register_column(:default_version_ids, field: :default_version_id)
    .register_column(:policy_names, field: :policy_name)
    .register_column(:policy_ids, field: :policy_id)
    .register_column(:permissions_boundary_usage_count, field: :permissions_boundary_usage_count)
    .register_column(:descriptions, field: :description)
    .register_column(:create_date, field: :create_date)
    .register_column(:update_date, field: :update_date)
    .register_column(:update_date, field: :update_date)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(allow: %i(scope))
    if !opts[:scope].nil? && !(%w{All AWS Local}.include? opts[:scope])
      raise ArgumentError, "#{@__resource_name__}: Scope accepts one out of 'All','AWS', 'Local'"
    end
    @table = fetch_data
  end

  def fetch_data
    iam_policy_rows = []
    parameters = {}
    parameters[:scope] = opts[:scope] if opts[:scope]
    parameters[:max_items] = 1000
    loop do
      catch_aws_errors do
        @response = @aws.iam_client.list_policies(parameters)
      end
      return iam_policy_rows if !@response || @response.empty?
      @response.policies.each do |policies|
        iam_policy_rows += [{ arn:                              policies.arn,
                              attachment_count:                 policies.attachment_count,
                              default_version_id:               policies.default_version_id,
                              policy_name:                      policies.policy_name,
                              policy_id:                        policies.policy_id,
                              permissions_boundary_usage_count: policies.permissions_boundary_usage_count,
                              description:                      policies.description,
                              create_date:                      policies.create_date,
                              update_date:                      policies.update_date,
                              tags:                             policies.tags }]
      end
      break unless @response.is_truncated
      break unless @response.marker
      parameters[:marker] = @response.marker
    end
    @table = iam_policy_rows
  end
end
