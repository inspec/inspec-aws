# frozen_string_literal: true

require 'aws_backend'

class AWSSDBDomains < AwsResourceBase
  name 'aws_sdb_domains'
  desc 'Verifies settings for Cloudwatch insight rules in bulk.'
  example "
    describe aws_sdb_domains do
      it { should exist }
    end
  "

  attr_reader :table

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  FilterTable.create
             .register_column(:domain_names, field: :name)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @insight_rules = @aws.list_domains.map do |domains|
        domains.domain_names.map { |domain| {
          domain_names: domain[:domain_names],
        }
        }
      end.flatten
    end
  end
end
