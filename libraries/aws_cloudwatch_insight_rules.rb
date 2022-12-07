require 'aws_backend'

class AWSCloudwatchInsightRules < AwsResourceBase
  name 'aws_cloudwatch_insight_rules'
  desc 'Verifies settings for Cloudwatch insight rules in bulk.'

  example "
    describe aws_cloudwatch_insight_rules do
      it { should exist }
    end
  "

  attr_reader :table

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  FilterTable.create
             .register_column(:names, field: :name)
             .register_column(:states, field: :state)
             .register_column(:schemas, field: :schema)
             .register_column(:definitions, field: :definition)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @insight_rules = @aws.cloudwatch_client.describe_insight_rules.map do |rules|
        rules.insight_rules.map { |insight_rules| {
          name: insight_rules[:name],
          state: insight_rules[:state],
          schema: insight_rules[:schema],
          definition: insight_rules[:definition],
        }
        }
      end.flatten
    end
  end
end
