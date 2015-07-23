class UrlValidator < ActiveModel::EachValidator

  def validate_each record, attribute, value
    unless valid?(value)
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

  def valid? value
    uri = URI.parse(value)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end

end