require "aws_backend"

class AWSEc2LaunchTemplates < AwsResourceBase
  name "aws_ec2_launch_templates"
  desc "Verifies settings for a collection of launch templates."

  example "
    describe aws_ec2_launch_templates do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:launch_template_ids,           field: :launch_template_id)
    .register_column(:launch_template_names,         field: :launch_template_name)
    .register_column(:create_time,                   field: :create_time)
    .register_column(:created_by,                    field: :created_by)
    .register_column(:default_version_number,        field: :default_version_number)
    .register_column(:tags,                          field: :tags)
    .register_column(:latest_version_number,         field: :launch_template_number)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    launch_template_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_launch_templates(pagination_options)
      end
      return launch_template_rows if !@api_response || @api_response.empty?
      @api_response.launch_templates.each do |launch_template|
        launch_template_tags = map_tags(launch_template.tags)
        launch_template_rows += [{
          launch_template_id: launch_template.launch_template_id,
          launch_template_name: launch_template.launch_template_name,
          create_time: launch_template.create_time,
          created_by: launch_template.created_by,
          tags: launch_template_tags,
          launch_template_tags_name: launch_template_tags["Name"],
          default_version_number: launch_template.default_version_number,
          latest_version_number: launch_template.latest_version_number,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = launch_template_rows
  end
end
