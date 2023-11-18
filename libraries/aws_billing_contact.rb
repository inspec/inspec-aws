require "aws_backend"
# require "pry"

class AwsBillingAccount < AwsResourceBase
  name "aws_billing_contact"
  desc "Verifies the billing contact information for an AWS Account."
  example <<~EXAMPLE
      describe aws_billing_account do
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
    validate_parameters
    begin
      catch_aws_errors { @aws_account_id = fetch_aws_account }
      @api_response = fetch_aws_alternate_contact(@aws, "billing")
    rescue Aws::Account::Errors::ResourceNotFoundException
      skip_resource(
        "The BILLING contact has not been configured for this AWS Account."
      )
      return [] if !@api_response || @api_response.empty?
    end

    unless @api_response.nil?
      @api_response
        .members
        .map(&:to_s)
        .each do |key|
          instance_variable_set("@#{key}", @api_response.send(key))
        end
      @raw_data = @api_response.to_h.transform_keys(&:to_s)
    else
      @name, @email_address, @phone_number, @title = nil
    end
  end

  def configured?
    !@api_response.nil? || !@raw_data
  end

  alias exist? configured?

  def resource_id
    if @aws_account_id
      "AWS Billing Contact for account: #{@aws_account_id}"
    else
      "AWS Billing Contact Information"
    end
  end

  def to_s
    if @aws_account_id
      "AWS Billing Contact for account: #{@aws_account_id}"
    else
      "AWS Account Primary Contact"
    end
  end

  private

  def fetch_aws_account
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(":")[4]
  end

  def fetch_aws_alternate_contact(aws_client, type)
    aws_client
      .account_client
      .get_alternate_contact({ alternate_contact_type: "#{type.uppercase}" })
      .alternate_contact
  end
end
