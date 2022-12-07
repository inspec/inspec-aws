require 'aws-sdk-core'
require 'aws_lambda'

class AwsLambdaTests < Minitest::Test

  def setup

    def get_function_data(function_name)
      mock_data         ={}
      mock_data[:configuration] = {
        :function_name => function_name,
        :function_arn => "arn:aws:lambda:eu-west-2:123456789012:function:#{function_name}",
        :runtime => "python2.7",
        :role => "arn:aws:iam::123456789012:role/service-role/#{function_name}-role",
        :handler => "#{function_name}-role.lambda_handler",
        :code_size => 6504139,
        :description => "[FILTERED]",
        :timeout => 300,
        :memory_size => 128,
        :code_sha_256 => "EIXM3fTCm3uMPfwFQRsyA6E5Zu4r8tCxxSJDLusZy1s=",
        :version => "$LATEST",
        :vpc_config => nil,
        :dead_letter_config => nil,
        :master_arn => nil,
        :revision_id => "7c43aa80-b183-4caf-a196-113e6add2886",
        :layers => nil
      }
      mock_data[:code] = {
        :repository_type => "S3",
        :location => "https://awslambda-eu-west-2-tasks.s3.eu-west-2.amazonaws.com/snapshots/123456789012/"
      }
      mock_data[:tags] =  {"Owner"=>"Arnold Rimmer", "lambda_id"=>function_name }
  
      return mock_data
    end

    function_call          = {}
    function_call[:method] = :get_function
    function_call[:data]   = get_function_data("function-one") 
    function_call[:client] = Aws::Lambda::Client

    @lambda = AwsLambda.new(lambda_name: 'function_one', client_args: { stub_responses: true }, stub_data: [function_call])
  end

  def test_exists_works_known()
    assert @lambda.exists?()
  end

  def test_exists_works_unknown()
    function_call          = {}
    function_call[:method] = :get_function
    function_call[:client] = Aws::Lambda::Client
    function_call[:data]   = {}

    local_lambda = AwsLambda.new(lambda_name: 'function_not', client_args: { stub_responses: true }, stub_data: [function_call])

    refute local_lambda.exists?()
  end

  def test_role_validation_works()
    assert_equal("arn:aws:iam::123456789012:role/service-role/function-one-role", @lambda.role)
  end

  def test_role_validation_works_unknown()
    refute_equal("arn:aws:iam::123456789012:role/service-role/function-two-role", @lambda.role)
  end

  def test_resource_id
    refute_nil(@lambda.resource_id)
    assert_equal(@lambda.resource_id, 'function_one')
  end
end