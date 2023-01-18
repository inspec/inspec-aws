require "aws_backend"

class AWSSESTemplates < AwsResourceBase
  name "aws_ses_templates"
  desc "Lists the email templates present in your Amazon SES account in the current AWS Region."

  example "
    describe aws_ses_templates do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:names, field: :name)
    .register_column(:created_timestamps, field: :created_timestamp)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.ses_client.list_templates.map do |table|
        table.templates_metadata.map { |table_name| {
          name: table_name.name,
          created_timestamp: table_name.created_timestamp,
        }
        }
      end.flatten
    end
  end
end
