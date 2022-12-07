require 'aws_backend'

class AWSWAFRules < AwsResourceBase
  name 'aws_waf_rules'
  desc 'Verifies settings for all the WAF rules.'

  example "
    describe aws_waf_rules do
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
             .register_column(:rule_ids, field: :rule_id)
             .register_column(:names, field: :name)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.waf_client.list_rules.map do |table|
        table.rules.map { |table_name| {
          rule_id: table_name[:rule_id],
          name: table_name[:name],
        }
        }
      end.flatten
    end
  end
end
