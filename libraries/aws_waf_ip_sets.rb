require 'aws_backend'

class AWSWAFIPSets < AwsResourceBase
  name 'aws_waf_ip_sets'
  desc 'Verifies settings for all the IP sets.'

  example "
    describe aws_waf_ip_sets do
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
             .register_column(:ip_set_ids, field: :ip_set_id, style: :simple)
             .register_column(:names, field: :name, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.waf_client.list_ip_sets.map do |table|
        table.map { |table_name| {
          name: table_name.ip_sets.map(&:name),
          ip_set_id: table_name.ip_sets.map(&:ip_set_id),
        }
        }
      end.flatten
    end
  end
end
