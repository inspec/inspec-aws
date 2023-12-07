require "aws_backend"

class AwsSecurityAccount < AwsResourceBase
  name "aws_security_contact"
  desc "Verifies the security contact information for an AWS Account."
  example <<~EXAMPLE
    describe aws_security_account do
      it { should be_configured }
      its('name') { should cmp 'John Smith' }
      its('email_address') { should cmp 'jsmith@acme.com' }
    end
  EXAMPLE

  attr_reader :raw_data,
              :api,
              :api_response,
              :email_address,
              :name,
              :phone_number,
              :title,
              :aws_account_id

  def initialize(opts = {})
    super(opts)
    @raw_data = {}
    @title, @name, @email_address, @phone_number = ""
    validate_parameters
    begin
      catch_aws_errors do
        @aws_account_id = fetch_aws_account
        @api_response = fetch_aws_alternate_contact("security")
      rescue Aws::Account::Errors::ResourceNotFoundException
        @api_response = nil
        skip_resource(
          "The Security contact has not been configured for this AWS Account.",
        )
      rescue Aws::Errors::NoSuchEndpointError
        @api_response = nil
        skip_resource(
          "The account contact endpoint is not available in this segment, please review this via the AWS Management Console.",
        )
      end
      return [] if !@api_response || @api_response.empty?
    end

    if @api_response
      @api_response
        .members
        .map(&:to_s)
        .each do |key|
          instance_variable_set("@#{key}", @api_response.send(key))
        end
    end
    @raw_data = @api_response.to_h.transform_keys(&:to_s)
  end

  def configured?
    !@api_response.nil? || !@raw_data
  end

  alias exist? configured?

  def resource_id
    if @aws_account_id
      "AWS Security Contact for account: #{@aws_account_id}"
    else
      "AWS Security Contact Information"
    end
  end

  def to_s
    if @aws_account_id
      "AWS Security Contact for account: #{@aws_account_id}"
    else
      "AWS Account Primary Contact"
    end
  end

  private

  def fetch_aws_account
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(":")[4]
  end

  def fetch_aws_alternate_contact(type)
    @aws
      .account_client
      .get_alternate_contact({ alternate_contact_type: type.upcase.to_s })
      .alternate_contact
  end
end
