require 'aws-sdk-core'
require 'aws_lambdas'

class AwsLambdasTests < Minitest::Test

  def setup
    def get_list_data
      list_data = {}
      list_data[:functions] = [
        {
          :function_name  => "Function One",
          :function_arn  => "arn:aws:lambda:eu-west-2:123456789012:function:function-one",
          :runtime  => "python2.7",
          :role  => "arn:aws:iam::123456789012:role/service-role/function-one-role",
          :handler  => "function-one-role.lambda_handler",
          :code_size  => 6504139,
          :description  => "[FILTERED]",
          :timeout  => 300,
          :memory_size  => 128,
          :code_sha_256  => "EIXM3fTCm3uMPfwFQRsyA6E5Zu4r8tCxxSJDLusZy1s=",
          :version  => "$LATEST",
          :vpc_config  => nil,
          :dead_letter_config  => nil,
          :master_arn  => nil,
          :revision_id  => "7c43aa80-b183-4caf-a196-113e6add2886",
          :layers  => nil
        },
        {
          :function_name  => "Function Two",
          :function_arn  => "arn:aws:lambda:eu-west-2: 123456789012:function:function-two",
          :runtime  => "dotnetcore2.1",
          :role  => "arn:aws:iam::123456789012:role/function-two-role",
          :handler  => "function-two.handler",
          :code_size  => 3842249,
          :description  => "[FILTERED]",
          :timeout  => 30,
          :memory_size  => 1024,
          :code_sha_256  => "zsvnfcqtAyfTiKXJ97rWmCFwAjdRg76bqgFecanXYqg=",
          :version  => "$LATEST",
          :vpc_config  => {
            :subnet_ids  => [
              "subnet-026f1f1d5",
              "subnet-0f5451308",
              "subnet-08a7ff399"
            ],
            :security_group_ids  => [
              "sg-0276dc76c9"
            ],
            :vpc_id  => "vpc-0cce833"
          },
          :dead_letter_config  => nil,
          :environment  => {},
          :kms_key_arn  => nil,
          :tracing_config  => {
            :mode  => "PassThrough"
          },
          :master_arn  => nil,
          :revision_id  => "b3904baa-0aa4-4fc1-b964-6490c3517c43",
          :layers  => nil
        },
        {
          :function_name  => "Function Three",
          :function_arn  => "arn:aws:lambda:eu-west-2: 123456789012:function:function-three",
          :runtime  => "dotnetcore2.1",
          :role  => "arn:aws:iam::123456789012:role/function-three-role",
          :handler  => "function-three.entry_point",
          :code_size  => 3842249,
          :description  => "[FILTERED]",
          :timeout  => 30,
          :memory_size  => 1024,
          :code_sha_256  => "zsvnfcqtAyfTiKXJ97rWmCFwAjdRg76bqgFecanXYqg=",
          :version  => "$LATEST",
          :vpc_config  => {
            :subnet_ids  => [
              "subnet-026f1f1d",
              "subnet-0f545130",
              "subnet-08a7ff39"
            ],
            :security_group_ids  => [
              "sg-0276dc76"
            ],
            :vpc_id  => "vpc-0cce833"
          },
          :dead_letter_config => nil,
          :environment => {},
          :kms_key_arn => nil,
          :tracing_config => {
            :mode => "PassThrough"
          },
          :master_arn => nil,
          :revision_id => "69a8a7f6-d1fd-40bf-b4e2-41fde3eeb320",
          :layers => nil
        }      
      ]
  
      return list_data
    end
  
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
      mock_data[:tags] =  {"Owner"=>"Dave Lister", "lambda_id"=>function_name }
  
      return mock_data
    end

    list_call = {}
    list_call[:method] = :list_functions
    list_call[:client] = Aws::Lambda::Client
    list_call[:data]   = get_list_data

    function_call          = {}
    function_call[:method] = :get_function
    function_call[:data]   = get_function_data("function-one") 
    function_call[:client] = Aws::Lambda::Client

    @lambdas = AwsLambdas.new(client_args: { stub_responses: true }, stub_data: [list_call, function_call])
  end

  def test_count_works
    assert_equal(3, @lambdas.count)
  end

  def test_contains_works
    assert @lambdas.names.include?("Function One")
  end

  def test_contains_works_not_present
    refute @lambdas.names.include?("Function Four")
  end

  def test_tags_iterate_works
    count=0
    @lambdas.tags.each_with_index {|k, v|
      count+= 1
    }

    assert_equal(3, count)
  end
end