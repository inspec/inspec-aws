require "aws_backend"

class AWSWAFV2ByteMatchSets < AwsResourceBase
  name "aws_wafv2_byte_match_sets"
  desc "Verifies settings for all the WAF rules."

  example "
    describe aws_wafv2_byte_match_sets do
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
    .register_column(:byte_match_set_ids, field: :byte_match_set_id, style: :simple)
    .register_column(:names, field: :name, style: :simple)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.waf_client_v2.list_byte_match_sets.map do |table|
        table.map { |table_name| {
          byte_match_set_id: table_name.byte_match_sets.map(&:byte_match_set_id),
          name: table_name.byte_match_sets.map(&:name),
        }
        }
      end.flatten
    end
  end
end
