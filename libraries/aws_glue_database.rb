require "aws_backend"

class AWSGlueDatabase < AwsResourceBase
  name "aws_glue_database"
  desc "Retrieves the definition of a specified database."

  example "
    describe aws_glue_database(name: 'db_name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:name])
    raise ArgumentError, "#{@__resource_name__}: name must be provided" unless opts[:name] && !opts[:name].empty?
    @display_name = opts[:name]
    catch_aws_errors do
      resp = @aws.glue_client.get_database({ name: opts[:name] })
      @res = resp.database.to_h
      create_resource_methods(@res)
    end
  end

  def name
    return nil unless exists?
    @res[:name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Glue Name: #{@display_name}"
  end
end
