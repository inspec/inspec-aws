require "aws_backend"

class AWSAmplifyApp < AwsResourceBase
  name "aws_amplify_app"
  desc "Describes a Amplify App."
  example <<-EXAMPLE
    describe aws_amplify_app(app_id: 'APP_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { app_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:app_id])

    raise ArgumentError, "#{@__resource_name__}: app_id must be provided" unless opts[:app_id] && !opts[:app_id].empty?
    @display_name = opts[:app_id]
    resp = @aws.amplify_client.get_app({ app_id: opts[:app_id] })
    @apps = resp.app.to_h
    create_resource_methods(@apps)
  end

  def app_id
    return unless exists?
    @apps[:app_id]
  end

  def resource_id
    @apps? @apps[:app_id] : @display_name
  end

  def exists?
    !@apps.nil? && !@apps.empty?
  end

  def to_s
    "Amplify App ID: #{@display_name}"
  end
end
