require 'aws_backend'

class AWSIAMSSHPublicKey < AwsResourceBase
  name 'aws_iam_ssh_public_key'
  desc 'Retrieves the specified SSH public key, including metadata about the key.'

  example "
    describe aws_iam_ssh_public_key(user_name: 'USER_NAME', ssh_public_key_id: 'SSH_PUBLIC_KEY_ID', encoding: 'SSH') do
      it { should exist }
    end

    describe aws_iam_ssh_public_key(user_name: 'USER_NAME', ssh_public_key_id: 'SSH_PUBLIC_KEY_ID', encoding: 'SSH') do
       its('ssh_key_age_valid') { should eq true }
     end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(user_name ssh_public_key_id encoding))
    raise ArgumentError, "#{@__resource_name__}: user_name must be provided" unless opts[:user_name] && !opts[:user_name].empty?
    raise ArgumentError, "#{@__resource_name__}: ssh_public_key_id must be provided" unless opts[:ssh_public_key_id] && !opts[:ssh_public_key_id].empty?
    raise ArgumentError, "#{@__resource_name__}: encoding must be provided" unless opts[:encoding] && !opts[:encoding].empty?
    @display_name = opts[:ssh_public_key_id]
    catch_aws_errors do
      resp = @aws.iam_client.get_ssh_public_key({ user_name: opts[:user_name], ssh_public_key_id: opts[:ssh_public_key_id], encoding: opts[:encoding] })
      @res = resp.ssh_public_key.to_h
      @user_name = @res[:user_name]
      @ssh_public_key_id = @res[:ssh_public_key_id]
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@user_name}_#{@ssh_public_key_id}"
  end

  def ssh_public_key_id
    return nil unless exists?
    @res[:ssh_public_key_id]
  end

  def ssh_key_age_valid
    return nil unless exists?
    result = (Time.now - @res[:upload_date]).to_i / (24 * 60 * 60)
    return false if result > 730
    true
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "SSH Public Key ID: #{@display_name}"
  end
end
