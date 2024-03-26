require "aws_backend"

class AWSWAFV2SQLInjectionMatchSets < AwsResourceBase
  name "aws_wafv2_sql_injection_match_sets"
  desc "Verifies settings for all the WAF SQL Injection match set."

  example "
    describe aws_wafv2_sql_injection_match_sets do
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
    .register_column(:sql_injection_match_set_ids, field: :sql_injection_match_set_id, style: :simple)
    .register_column(:names, field: :name, style: :simple)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.waf_client_v2.list_sql_injection_match_sets.map do |table|
        table.map { |table_name| {
          sql_injection_match_set_id: table_name.sql_injection_match_sets.map(&:sql_injection_match_set_id),
          name: table_name.sql_injection_match_sets.map(&:name),
        }
        }
      end.flatten
    end
  end
end
