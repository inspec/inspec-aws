require 'securerandom'

class AwsGivens

  # Standardised AWS "arn" field.
  def any_arn(components = {})
    "arn:aws:mocked::#{any_int}:#{any_string}/#{any_string}" if components.empty?

    arn = ''
    components.key?(:arn)        ? arn << "#{components[:arn]}:"        : arn << 'arn:'
    components.key?(:partition)  ? arn << "#{components[:partition]}:"  : arn << 'aws:'
    components.key?(:service)    ? arn << "#{components[:service]}:"    : arn << 'mocked:'
    components.key?(:region)     ? arn << "#{components[:region]}:"     : arn << "#{any_region}:"
    components.key?(:account_id) ? arn << "#{components[:account_id]}:" : arn << "#{any_int}:"
    components.key?(:resource)   ? arn << "#{components[:resource]}:"   : arn << "#{any_string}:"
    arn
  end

  # Any standardised AWS "id" field.
  def any_id
    "i-" + any_hex
  end

  # Any hexadecimal string
  def any_hex(max = 16)
    SecureRandom.hex[0..max]
  end

  # Any positive integer
  def any_int(max = 12)
    max = max - 1 if max > 1
    SecureRandom.random_number(max) + 1
  end

  def any_string(max = 12)
    (0...max).map { rand(65..90).chr }.join.downcase.to_s
  end

  def any_date
    Time.at(rand * Time.now.to_i)
  end

  def any_region
    %W(us-east-1, us-east-2, us-west-1, us-west-2, eu-west-1, eu-west-2, eu-west-3, eu-central-1).sample
  end

  def any_email
    "#{any_string}@#{any_string}.com"
  end

  def any_array_of_string(max = 6)
    (0..max).collect { any_string }
  end
end
