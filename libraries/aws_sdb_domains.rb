require 'aws_backend'

class AWSSDBDomains < AwsResourceBase
  name 'aws_sdb_domains'
  desc 'Verifies settings for SDB Domain in bulk.'

  example "
    describe aws_sdb_domains do
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
             .register_column(:domain_names, field: :domain_names, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.simpledb_client.list_domains.map do |table|
        table.map { |table_name| {
          domain_names: table_name[:domain_names],
        }
        }
      end.flatten
    end
  end
end
