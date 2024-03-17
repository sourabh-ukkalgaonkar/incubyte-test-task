# frozen_string_literal: true
require 'pry'
class StringCalculator
  attr_accessor :string, :delimiter, :custom_delimiter

  class InvalidInputError < StandardError; end
  class NegativeNumberInputError < StandardError; end

  DEFAULT_DELIMITER = ','
  CUSTOM_DELIMITER_STRING_START_CHAR = '//'
  NEGATIVE_CHAR_SIGN = '-'

  def initialize(str)
    @string = str.gsub('\\n', ',').gsub('\n', ',')
    @custom_delimiter = false
  end

  def add
    find_delimiter
    matched_string_by_custom_delimiter
    check_negative_string!
    sum
  rescue NegativeNumberInputError => e
    e.message
  rescue InvalidInputError => e
    e.message
  rescue StandardError => e
    e.message
  end

  private

  def find_delimiter
    @delimiter = if string.start_with?(CUSTOM_DELIMITER_STRING_START_CHAR)
                   @custom_delimiter = true
                   string[2]
                 else
                   DEFAULT_DELIMITER
                 end
  end

  def matched_string_by_custom_delimiter
    return string unless custom_delimiter

    match_data = string.match(/^\/\/(.+)(.+)$/)
    match_data[2]
  end

  def check_negative_string!
    negative_numbers = string.scan(/-\d+/).map(&:to_i)

    return if negative_numbers.empty?

    raise NegativeNumberInputError,
          "Negative numbers are not allowed: #{negative_numbers.join(', ')}"
  end

  def sum
    chars = string.split('')
    raise InvalidInputError, 'Invalid Inputs' if chars[0] == delimiter || chars[chars.length - 1] == delimiter
    return 0 if chars.empty?

    string.scan(/\d+/).map(&:to_i).inject(:+)
  end
end
