require "aws_backend"

class AWSAthenaWorkGroup < AwsResourceBase
  name "aws_athena_work_group"
  desc "Returns information about the workgroup with the specified name."
  example <<-EXAMPLE
    describe aws_athena_work_group(work_group: 'ATHENA_WORK_GROUP') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { work_group: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:work_group])

    raise ArgumentError, "#{@__resource_name__}: work_group must be provided" unless opts[:work_group] && !opts[:work_group].empty?
    @display_name = opts[:work_group]
    catch_aws_errors do
      resp = @aws.athena_client.get_work_group({ work_group: opts[:work_group] })
      @work_group = resp.work_group.to_h
      create_resource_methods(@work_group)
    end
  end

  def work_group
    return nil unless exists?
    @work_group[:work_group]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@work_group.nil? && !@work_group.empty?
  end

  def to_s
    "WorkGroup Name: #{@display_name}"
  end
end
