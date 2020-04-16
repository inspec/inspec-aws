# frozen_string_literal: true

require 'aws_backend'

class AwsHostedZones < AwsResourceBase
  name 'aws_hosted_zones'
  desc 'Verifies hosted zones settings are correct'

  example "
    describe aws_hosted_zones() do
      it { should exist }
      its ('name') { should include ('carry-on.films.com'))}
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:name, field: :name)
             .register_column(:id, field: :id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    zones = []
    catch_aws_errors do
      resp =@aws.route53_client.list_hosted_zones

      resp.hosted_zones.each do |zone|
        zones += [{
          name: zone.name,
          id: zone.id,
        }]
      end
    end

    @table = zones
  end
end
