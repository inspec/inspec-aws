require 'aws-sdk-core'
require 'aws_lambdas'

class AwsLambdasTests < Minitest::Test

  def setup
    lambda_list_call = {}
    lambda_list_call[:method] = :list_functions
    lambda_list_call[:client] = Aws::Lambda::Client
    lambda_list_call[:data]   = {

      "next_marker": "nil",
      "functions": [
        {
          "function_name": "Function One",
          "function_arn": "arn:aws:lambda:eu-west-2:123456789012:function:function-one",
          "runtime": "python2.7",
          "role": "arn:aws:iam::123456789012:role/service-role/function-one-role",
          "handler": "function-one-role.lambda_handler",
          "code_size": 6504139,
          "description": "[FILTERED]",
          "timeout": 300,
          "memory_size": 128,
          "code_sha_256": "EIXM3fTCm3uMPfwFQRsyA6E5Zu4r8tCxxSJDLusZy1s=",
          "version": "$LATEST",
          "vpc_config": nil,
          "dead_letter_config": nil,
          "master_arn": "nil",
          "revision_id": "7c43aa80-b183-4caf-a196-113e6add2886",
          "layers": nil
        },
        {
          "function_name": "Function Two",
          "function_arn": "arn:aws:lambda:eu-west-2: 123456789012:function:function-two",
          "runtime": "dotnetcore2.1",
          "role": "arn:aws:iam::123456789012:role/function-two-role",
          "handler": "function-two.handler",
          "code_size": 3842249,
          "description": "[FILTERED]",
          "timeout": 30,
          "memory_size": 1024,
          "code_sha_256": "zsvnfcqtAyfTiKXJ97rWmCFwAjdRg76bqgFecanXYqg=",
          "version": "$LATEST",
          "vpc_config": {
            "subnet_ids": [
              "subnet-026f1f1d5",
              "subnet-0f5451308",
              "subnet-08a7ff399"
            ],
            "security_group_ids": [
              "sg-0276dc76c9"
            ],
            "vpc_id": "vpc-0cce833"
          },
          "dead_letter_config": nil,
          "environment": {},
          "kms_key_arn": nil,
          "tracing_config": {
            "mode": "PassThrough"
          },
          "master_arn": nil,
          "revision_id": "b3904baa-0aa4-4fc1-b964-6490c3517c43",
          "layers": nil
        },
        {
          "function_name": "Function Three",
          "function_arn": "arn:aws:lambda:eu-west-2: 123456789012:function:function-three",
          "runtime": "dotnetcore2.1",
          "role": "arn:aws:iam::123456789012:role/function-three-role",
          "handler": "function-three.entry_point",
          "code_size": 3842249,
          "description": "[FILTERED]",
          "timeout": 30,
          "memory_size": 1024,
          "code_sha_256": "zsvnfcqtAyfTiKXJ97rWmCFwAjdRg76bqgFecanXYqg=",
          "version": "$LATEST",
          "vpc_config": {
            "subnet_ids": [
              "subnet-026f1f1d",
              "subnet-0f545130",
              "subnet-08a7ff39"
            ],
            "security_group_ids": [
              "sg-0276dc76"
            ],
            "vpc_id": "vpc-0cce833"
          },
          "dead_letter_config": nil,
          "environment": {},
          "kms_key_arn": nil,
          "tracing_config": {
            "mode": "PassThrough"
          },
          "master_arn": nil,
          "revision_id": "69a8a7f6-d1fd-40bf-b4e2-41fde3eeb320",
          "layers": nil
        }
      ]
    }
    
    lambda_call               = {}
    lambda_call[:method]      = :get_function
    lambda_call[:client] = Aws::Lambda::Client
    lambda_call[:data]        = {
      "configuration": {
        "function_name": "Function One",
        "function_arn": "arn:aws:lambda:eu-west-2:123456789012:function:function-one",
        "runtime": "python2.7",
        "role": "arn:aws:iam::123456789012:role/service-role/function-one-role",
        "handler": "function-one-role.lambda_handler",
        "code_size": 6504139,
        "description": "[FILTERED]",
        "timeout": 300,
        "memory_size": 128,
        "code_sha_256": "EIXM3fTCm3uMPfwFQRsyA6E5Zu4r8tCxxSJDLusZy1s=",
        "version": "$LATEST",
        "vpc_config": nil,
        "dead_letter_config": nil,
        "master_arn": "nil",
        "revision_id": "7c43aa80-b183-4caf-a196-113e6add2886",
        "layers": nil
      },
      "code": {
        "repository_type": "S3",
        "location": "https://awslambda-eu-west-2-tasks.s3.eu-west-2.amazonaws.com/snapshots/123456789012/"
      },
      "tags":[
        { "key": "Name", "value": "inspec-ebs-volume-name" },
        { "key": "Name2", "value": "inspec-ebs-volume-name" },
      ],
      "concurrency": nil
    }

    @lambdas = AwsLambdas.new(client_args: { stub_responses: true }, stub_data: [lambda_list_call, lambda_call])
  end

  def test_count_works
    assert_equal(3, @lambdas.count)
  end

  def test_contains_works
    assert @lambdas.names.include?("Function One")
  end
end