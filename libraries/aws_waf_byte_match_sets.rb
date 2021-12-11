# frozen_string_literal: true

require 'aws_backend'

class AWSWAFByteMatchSets < AwsResourceBase
  name 'aws_waf_byte_match_sets'
  desc 'Verifies settings for all the WAF rules.'

  example "
    describe aws_waf_byte_match_sets do
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
             .register_column(:byte_match_set_ids, field: :byte_match_set_id)
             .register_column(:names, field: :name)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.waf_client.list_byte_match_sets.map do |table|
        table.map { |table_name| {
          byte_match_set_id: table_name[:byte_match_set_id],
          name: table_name[:name],
        }
        }
      end.flatten
    end
  end
end
