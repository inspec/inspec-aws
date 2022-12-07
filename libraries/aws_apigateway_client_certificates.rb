require 'aws_backend'

class AWSApiGatewayClientCertificates < AwsResourceBase
  name 'aws_apigateway_client_certificates'
  desc 'Gets a collection of ClientCertificate resources.'

  example "
    describe aws_apigateway_client_certificates do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:client_certificate_ids, field: :client_certificate_id)
             .register_column(:descriptions, field: :description)
             .register_column(:pem_encoded_certificates, field: :pem_encoded_certificate)
             .register_column(:created_dates, field: :created_date)
             .register_column(:expiration_dates, field: :expiration_date)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_client_certificates.map do |table|
        table.items.map { |table_name| {
          client_certificate_id: table_name.client_certificate_id,
          description: table_name.description,
          pem_encoded_certificate: table_name.pem_encoded_certificate,
          created_date: table_name.created_date,
          expiration_date: table_name.expiration_date,
          tags: table_name.tags,
        }
        }
      end.flatten
    end
  end
end
