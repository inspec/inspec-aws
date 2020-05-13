# frozen_string_literal: true

require 'aws_backend'

class AwsIamAccessKeys < AwsResourceBase
  name 'aws_iam_access_keys'
  desc 'Verifies settings for a collection of AWS IAM Access Keys'
  example '
    describe aws_iam_access_keys do
      it { should_not exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:access_key_ids,      field: :access_key_id)
             .register_column(:created_date,        field: :create_date)
             .register_column(:created_days_ago,    field: :created_days_ago)
             .register_column(:created_with_user,   field: :created_with_user)
             .register_column(:created_hours_ago,   field: :created_hours_ago)
             .register_column(:usernames,           field: :username)
             .register_column(:active,              field: :active)
             .register_column(:inactive,            field: :inactive)
             .register_column(:last_used_date,      field: :last_used_date)
             .register_column(:last_used_hours_ago, field: :last_used_hours_ago)
             .register_column(:last_used_days_ago,  field: :last_used_days_ago)
             .register_column(:ever_used,           field: :ever_used)
             .register_column(:never_used,          field: :never_used)
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
    users   = get_users(username)
    @table  = get_keys(users)
  end

  # Get details of a single user, if provided.
  # Otherwise, get details of all users.
  # Returns a map (K,V) of (username: user_details)
  def get_users(username = nil)
    catch_aws_errors do
      users = {}
      if username
        begin
          users[username] = @aws.iam_client.get_user(user_name: username).user
        rescue Aws::IAM::Errors::NoSuchEntity
          # Swallow - a miss on search results should return an empty table
        end
      else
        pagination = {}
        loop do
          resp = @aws.iam_client.list_users(pagination)
          resp.users.each do |user|
            users[user.user_name] = user
          end
          break unless resp.is_truncated
          pagination[:marker] = resp.marker
        end
      end
      users
    end
  end

  # Given a Hash of Users, build Access Key details for each.
  def get_keys(users)
    catch_aws_errors do
      access_key_data = []
      users.each_key do |username|
        begin
          user_keys = @aws.iam_client.list_access_keys(user_name: username)
                          .access_key_metadata
          user_keys = user_keys.map do |metadata|
            {
              access_key_id: metadata.access_key_id,
              username: username,
              status: metadata.status,
              create_date: metadata.create_date,
            }
          end

          user_keys.each do |key_info|
            merge(key_info, users[username])
          end
          access_key_data.concat(user_keys)
        rescue Aws::IAM::Errors::NoSuchEntity
          # Swallow - a miss on search results should return an empty table
        end
      end
      access_key_data
    end
  end

  # Flatten user details and key details into the FilterTable format.
  def merge(key_info, user_info)
    key_info[:id]       = key_info[:access_key_id]
    key_info[:active]   = key_info[:status] == 'Active'
    key_info[:inactive] = key_info[:status] != 'Active'
    key_info[:created_hours_ago]  = ((Time.now - key_info[:create_date]) / (60*60)).to_i
    key_info[:created_days_ago]   = (key_info[:created_hours_ago] / 24).to_i
    key_info[:user_created_date]  = user_info[:create_date]
    key_info[:created_with_user]  = (key_info[:create_date] - key_info[:user_created_date]).abs < 1.0/24.0

    catch_aws_errors do
      last_used =@aws.iam_client.get_access_key_last_used(access_key_id: key_info[:access_key_id])
                     .access_key_last_used
                     .last_used_date

      key_info[:ever_used]      = !last_used.nil?
      key_info[:never_used]     = last_used.nil?
      key_info[:last_used_time] = last_used
      return unless last_used
      key_info[:last_used_hours_ago] = ((Time.now - last_used) / (60*60)).to_i
      key_info[:last_used_days_ago] = (key_info[:last_used_hours_ago]/24).to_i
    end
  end
end
