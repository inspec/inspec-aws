require 'securerandom'

class AwsGivens

  # Standardised AWS "arn" field.
  def any_arn
    "arn:aws:mocked::#{any_int}:#{any_string}/#{any_string}"
  end

  # Any standardised AWS "id" field.
  def any_id
    "i-" + any_hex
  end

  # Any hexadecimal string
  def any_hex(max = 16)
    SecureRandom.hex[0..max]
  end

  def any_int(max = 12)
    SecureRandom.random_number(max)
  end

  def any_string(max = 12)
    (0...max).map { rand(65..90).chr }.join.downcase.to_s
  end

  def any_date
    Time.at(rand * Time.now.to_i)
  end

end