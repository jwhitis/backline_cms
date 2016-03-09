class SubdomainValidator < ActiveModel::EachValidator
  VALID_SUBDOMAIN_REGEX = /\A[a-z\d]+(-[a-z\d]+)*\z/

  def validate_each record, attribute, value
    unless value =~ VALID_SUBDOMAIN_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end