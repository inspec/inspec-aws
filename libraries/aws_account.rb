require "aws_backend"

class AwsAccount < AwsResourceBase
  name "aws_account"
  desc "Verifies contact information for an AWS Account."
  example "
    addr = { 'address_line_1' => '42 Wallaby Way', ... }
    describe aws_account.contact_information do
      it { should cmp addr }
    end
  "

  def initialize(opts = {})
    super(opts)
  end

  def resource_id
    "AWS Account Contact Information"
  end

  def to_s
    "AWS Account Contact Information"
  end

  def contact_information
    @contact_information ||= catch_aws_errors do
      @aws.account_client.get_contact_information.contact_information.to_h.transform_keys(&:to_s)
    end
  end

  def billing_contact_information
    @billing_contact_information ||= catch_aws_errors do
      @aws.account_client.get_alternate_contact("BILLING").alternate_contact.to_h.transform_keys(&:to_s)
    end
  end

  def operations_contact_information
    @operations_contact_information ||= catch_aws_errors do
      @aws.account_client.get_alternate_contact("OPERATIONS").alternate_contact.to_h.transform_keys(&:to_s)
    end
  end

  def security_contact_information
    @security_contact_information ||= catch_aws_errors do
      @aws.account_client.get_alternate_contact("SECURITY").alternate_contact.to_h.transform_keys(&:to_s)
    end
  end
end
