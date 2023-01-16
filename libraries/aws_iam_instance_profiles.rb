require "aws_backend"

class AWSIAMInstanceProfiles < AwsResourceBase
  name "aws_iam_instance_profiles"
  desc "Lists the instance profiles that have the specified path prefix."

  example "
    describe aws_iam_instance_profiles do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:paths,                                                   field: :path)
    .register_column(:instance_profile_names,                                  field: :instance_profile_name)
    .register_column(:instance_profile_ids,                                    field: :instance_profile_id)
    .register_column(:arns,                                                    field: :arn)
    .register_column(:create_dates,                                            field: :create_date)
    .register_column(:roles,                                                   field: :roles)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.iam_client.list_instance_profiles
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.instance_profiles.map(&:to_h)
  end
end
