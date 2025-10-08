require "aws_backend"

class AwsIamAccessKey < AwsResourceBase
  name "aws_iam_access_key"
  desc "Verifies settings for an AWS IAM Access Key."
  example "
    describe aws_iam_access_key(username: 'username', access_key_id: 'access-key id') do
      it                    { should exist }
      it                    { should_not be_active }
      its('create_date')    { should be > Time.now - 365 * 86400 }
      its('last_used_date') { should be > Time.now - 90 * 86400 }
    end
  "

  attr_reader :access_key_id, :create_date, :status, :username

  alias id access_key_id

  def initialize(opts = {})
    if opts.is_a?(String)
      # If String passed, determine if username or ID.
      if opts.start_with?("AKIA")
        opts = { access_key_id: opts }
      else
        opts = { username: opts }
      end
    elsif opts.key?(:id)
      # Otherwise if `id` is provided, use `access_key_id` instead.
      opts[:access_key_id] = opts.delete(:id)
    end

    if opts[:access_key_id] &&
         !/^AKIA[0-9A-Z]{16}$/.match?(opts[:access_key_id])
      raise ArgumentError,
            "#{@__resource_name__}: Incorrect format for provided Access Key ID"
    end

    super(opts)
    validate_parameters(require_any_of: %i[access_key_id username])

    @username = opts[:username]
    @access_key_id = opts[:access_key_id]

    catch_aws_errors do
      query = {}
      query[:user_name] = @username if @username

      resp = @aws.iam_client.list_access_keys(query)

      # Get all keys for the provided user. If no user provided, use current principal.
      # If an `access_key_id` has been provided, get only that key.
      access_keys =
        resp.access_key_metadata.select do |key|
          access_key_id ? key.access_key_id == access_key_id : true
        end

      return if access_keys.empty?
      if access_keys.count > 1
        raise 'Request returned more than 1 key. Please scope by `access_key_id` to find one key \
                or consider using the `aws_iam_access_keys` plural resource for multiple keys.'
      end

      @access_key_id = access_keys[0].access_key_id
      @username = access_keys[0].user_name
      @create_date = access_keys[0].create_date
      @status = access_keys[0].status
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
    return @last_used_date if defined?(@last_used_date)
    catch_aws_errors do
      @last_used_date =
        @aws
          .iam_client
          .get_access_key_last_used({ access_key_id: @access_key_id })
          .access_key_last_used
          .last_used_date
    end
  end
end
