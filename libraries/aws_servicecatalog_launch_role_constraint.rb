require 'aws_backend'

class AWSServiceCatalogLaunchRoleConstraint < AwsResourceBase
  name 'aws_servicecatalog_launch_role_constraint'
  desc 'Gets information about the specified constraint.'

  example "
    describe aws_servicecatalog_launch_role_constraint(id: 'Id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:id])
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    catch_aws_errors do
      resp = @aws.servicecatalog_client.describe_constraint({ id: opts[:id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res? @display_name : ''
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Constraint ID: #{@display_name}"
  end
end
