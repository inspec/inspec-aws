require 'aws_backend'

class AwsLambdas < AwsResourceBase
  name 'aws_lambdas'
  desc 'Verifies generic settings for a set of lambdas'
  example '
    describe aws_lambdas() do
      .....
    end
  '
  attr_reader :table

  FilterTable.create
             .register_column(:names, field: :name)
             .register_column(:arns, field: :arn)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    fetch_data
  end

  def fetch_data
    lambdas = []

    catch_aws_errors do
      returned_lambdas = @aws.lambda_client.list_functions
      return [] if !returned_lambdas || returned_lambdas.empty?

      returned_lambdas.functions.each { |lambda|
        puts "getting func #{lambda.function_name}"
        func = @aws.lambda_client.get_function({ function_name: lambda.function_name })

        puts "funcc #{func.tags}"
        lambdas += [{
          name: lambda.function_name,
          arn: lambda.function_arn,
          tags: func.tags,
          handler: lambda.handler,
        }]
      }
    end

    @table = lambdas
  end
end
