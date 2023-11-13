require 'aws_backend'

class AWSIAMServerCertificates < AwsResourceBase
  name 'aws_iam_server_certificates'
  desc 'Verifies the server certificates stored in IAM.'

  example "
    describe aws_iam_server_certificates do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:paths, field: :path)
             .register_column(:server_certificate_names, field: :server_certificate_name)
             .register_column(:server_certificate_ids, field: :server_certificate_id)
             .register_column(:arns, field: :arn)
             .register_column(:upload_date, field: :upload_date)
             .register_column(:expiration_date, field: :expiration_date)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    parameters={}
    iam_server_certificates_rows = []
    loop do
      catch_aws_errors do
        @response = @aws.iam_client.list_server_certificates(parameters)
      end
      return iam_server_certificates_rows if !@response || @response.empty?
      @response.server_certificate_metadata_list.each do |p|
        iam_server_certificates_rows += [{ path:                      p.path,
                                           server_certificate_name:   p.server_certificate_name,
                                           server_certificate_id:     p.server_certificate_id,
                                           arn:                       p.arn,
                                           upload_date:               p.upload_date,
                                           expiration_date:                p.expiration }]
      end
      break unless @response.is_truncated
      break unless @response.marker
      parameters[:marker] = @response.marker
    end
    @table = iam_server_certificates_rows
  end
end
