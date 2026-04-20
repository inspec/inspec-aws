require "aws_backend"

class AWSAmplifyBranch < AwsResourceBase
  name "aws_amplify_branch"
  desc "Describes a branch for an Amplify app."
  example <<-EXAMPLE
    describe aws_amplify_branch(app_id: 'APP_ID', branch_name: 'BRANCH_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { app_id: opts } if opts.is_a?(String)
    opts = { branch_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[app_id branch_name])
    unless opts[:app_id] && !opts[:app_id].empty? && opts[:branch_name] &&
             !opts[:branch_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: app_id and branch_name must be provided"
    end
    @display_name = opts[:branch_name]
    resp =
      @aws.amplify_client.get_branch(
        { app_id: opts[:app_id], branch_name: opts[:branch_name] }
      )
    @apps = resp.branch.to_h
    create_resource_methods(@apps)
  end

  def branch_name
    return nil unless exists?
    @apps[:branch_name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@apps.nil? && !@apps.empty?
  end

  def to_s
    "Amplify Branch Name: #{@display_name}"
  end
end
