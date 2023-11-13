require 'aws_backend'

class AWSHostedZones < AwsResourceBase
  name 'aws_hosted_zones'
  desc 'Retrieves a list of the public and private hosted zones that are associated with the current Amazon Web Services account.'

  example "
    describe aws_hosted_zones do
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
             .register_column(:ids, field: :id)
             .register_column(:names, field: :name)
             .register_column(:caller_references, field: :caller_reference)
             .register_column(:configs, field: :config)
             .register_column(:resource_record_set_counts, field: :resource_record_set_count)
             .register_column(:linked_services, field: :linked_service)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.route53_client.list_hosted_zones.map do |table|
        table.hosted_zones.map { |table_name| {
          id: table_name.id,
          name: table_name.name,
          caller_reference: table_name.caller_reference,
          config: table_name.config,
          resource_record_set_count: table_name.resource_record_set_count,
          linked_service: table_name.linked_service,
        }
        }
      end.flatten
    end
  end
end
