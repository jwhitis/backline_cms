class SlugValidator < ActiveModel::EachValidator
  VALID_SLUG_REGEX = /\A[a-z0-9\-_]+\z/

  def validate_each record, attribute, value
    unless value =~ VALID_SLUG_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end