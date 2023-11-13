require 'aws_backend'

class AwsIamAccessKeys < AwsCollectionResourceBase
  name 'aws_iam_access_keys'
  desc 'Verifies settings for a collection of AWS IAM Access Keys.'
  example "
    describe aws_iam_access_keys do
      it { should_not exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:usernames,           field: :username)
             .register_column(:access_key_ids,      field: :access_key_id)
             .register_column(:created_date,        field: :create_date)
             .register_column(:created_days_ago,    field: :created_days_ago)
             .register_column(:created_with_user,   field: :created_with_user)
             .register_column(:created_hours_ago,   field: :created_hours_ago)
             .register_column(:active,              field: :active)
             .register_column(:inactive,            field: :inactive)
             .register_column(:last_used_date,      field: :last_used_date, lazy_instance: :lazy_load_last_used_date)
             .register_column(:last_used_hours_ago, field: :last_used_hours_ago, lazy_instance: :lazy_load_last_used_hours_ago)
             .register_column(:last_used_days_ago,  field: :last_used_days_ago, lazy_instance: :lazy_load_last_used_days_ago)
             .register_column(:ever_used,           field: :ever_used, lazy_instance: :lazy_load_ever_used)
             .register_column(:never_used,          field: :never_used, lazy_instance: :lazy_load_never_used_time)
             .register_column(:user_created_date,   field: :user_created_date)
             .register_custom_matcher(:exists?) { |x| !x.entries.empty? }
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    opts = { username: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(allow: [:username])
    @table = fetch_data(opts[:username])
  end

  def to_s
    'IAM Access Keys'
  end

  private

  def fetch_data(username)
    @_users = get_users(username)
    @table = get_keys
  end

  # Get details of a single user, if provided.
  # Otherwise, get details of all users.
  # Returns a map (K,V) of (username: user_details)
  def get_users(username = nil)
    catch_aws_errors do
      if username
        [fetch_user(username)]
      else
        collect_all_users
      end
    end
  end

  def fetch_user(username)
    catch_aws_errors do
      iam_client.get_user(user_name: username).user
    rescue Aws::IAM::Errors::NoSuchEntity
      # Swallow - a miss on search results should return an empty table
    end
  end

  def collect_all_users
    catch_aws_errors do
      iam_client.list_users.flat_map(&:users)
    end
  end

  # Given a Hash of Users, build Access Key details for each.
  def get_keys
    @_users.flat_map do |user|
      fetch_keys(user.user_name)
    end
  end

  def fetch_keys(username)
    access_keys = catch_aws_errors do
      iam_client.list_access_keys({ user_name: username })
    rescue Aws::IAM::Errors::NoSuchEntity
      # Swallow - a miss on search results should return an empty table
    end
    access_keys&.flat_map do |response|
      response.access_key_metadata.flat_map do |access_key|
        access_key_hash = access_key.to_h
        access_key_hash[:username] = access_key_hash[:user_name]
        access_key_hash[:id] = access_key_hash[:access_key_id]
        access_key_hash[:active] = access_key_hash[:status] == 'Active'
        access_key_hash[:inactive] = access_key_hash[:status] != 'Active'
        access_key_hash[:created_hours_ago]  = ((Time.now - access_key_hash[:create_date]) / (60*60)).to_i
        access_key_hash[:created_days_ago]   = (access_key_hash[:created_hours_ago] / 24).to_i
        access_key_hash[:user_created_date]  = @_users.find { |user| user.user_name == access_key_hash[:username] }.create_date
        access_key_hash[:created_with_user]  = (access_key_hash[:create_date] - access_key_hash[:user_created_date]).abs < 1.0/24.0
        access_key_hash
      end
    end
  end

  def last_used(row, _condition, _table)
    catch_aws_errors do
      iam_client.get_access_key_last_used({ access_key_id: row[:access_key_id] })
                .access_key_last_used
    end
  end

  def lazy_load_last_used_date(row, condition, table)
    row[:last_used_date] ||= last_used(row, condition, table).last_used_date
  end

  def lazy_load_never_used_time(row, condition, table)
    row[:never_used] ||= lazy_load_last_used_date(row, condition, table).nil?
  end

  def lazy_load_ever_used(row, condition, table)
    row[:ever_used] ||= !lazy_load_never_used_time(row, condition, table)
  end

  def lazy_load_last_used_hours_ago(row, condition, table)
    return row[:last_used_hours_ago] = nil if lazy_load_never_used_time(row, condition, table)
    row[:last_used_hours_ago] = ((Time.now - row[:last_used_date]) / (60*60)).to_i
  end

  def lazy_load_last_used_days_ago(row, condition, table)
    return row[:last_used_days_ago] = nil if lazy_load_never_used_time(row, condition, table)
    if row[:last_used_hours_ago].nil?
      lazy_load_last_used_hours_ago(row, condition, table)
    end
    row[:last_used_days_ago] = (row[:last_used_hours_ago]/24).to_i
  end

  def iam_client
    @aws.iam_client
  end
end
