require "aws_backend"

class AWSApiGatewayClientCertificate < AwsResourceBase
  name "aws_apigateway_client_certificate"
  desc "Gets information about the current ClientCertificate resource."
  example <<-EXAMPLE
    describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { client_certificate_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[client_certificate_id])
    unless opts[:client_certificate_id] && !opts[:client_certificate_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: client_certificate_id must be provided"
    end
    @display_name = opts[:client_certificate_id]
    catch_aws_errors do
      resp =
        @aws.apigateway_client.get_client_certificate(
          { client_certificate_id: opts[:client_certificate_id] }
        )
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def client_certificate_id
    return unless exists?
    @res[:client_certificate_id]
  end

  def resource_id
    @res ? @res[:client_certificate_id] : @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Client Certificate ID: #{@display_name}"
  end
end
