require_relative 'aws_givens'

class AwsBaseResourceMock

  def initialize
    @aws = AwsGivens.new
  end

end