require "aws_backend"

class AwsAccount < AwsResourceBase
  name "aws_account"
  desc "Verifies settings for an AWS IAM Access Key."
  example "
    describe aws_account.contact_information do
      its('phone_number') { should eq '123-456-7890' }
    end
  "

  attr_reader :contact_information, :billing_contact_information, :operations_contact_information, :security_contact_information

  def initialize(opts = {})
    super(opts)

    catch_aws_errors do
      query = {}
      query[:user_name] = @username if @username

      resp = @aws.iam_client.list_access_keys(query)

      # Get all keys for the provided user. If no user provided, use current principal.
      # If an `access_key_id` has been provided, get only that key.
      access_keys = resp.access_key_metadata.select do |key|
        if access_key_id
          key.access_key_id == access_key_id
        else
          true
        end
      end

      return if access_keys.empty?
      if access_keys.count > 1
        raise 'Request returned more than 1 key. Please scope by `access_key_id` to find one key \
                or consider using the `aws_iam_access_keys` plural resource for multiple keys.'
      end

      @access_key_id = access_keys[0].access_key_id
      @username      = access_keys[0].user_name
      @create_date   = access_keys[0].create_date
      @status        = access_keys[0].status
    end
  end

  def resource_id
    @access_key_id
  end

  def active?
    return nil unless exists?
    status == "Active"
  end

  def exists?
    !@create_date.nil?
  end

  def to_s
    "AWS IAM Access Key #{@access_key_id} for User #{@username}"
  end

  def last_used_date
    return nil unless exists?
    return @last_used_date if defined? @last_used_date
    catch_aws_errors do
      @last_used_date = @aws.iam_client.get_access_key_last_used({ access_key_id: @access_key_id })
        .access_key_last_used
        .last_used_date
    end
  end
end
