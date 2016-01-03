class PresentModelValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    model_name = ['iphone', 'android', 'web']
    model_values = model_name.map { |name| record.__send__("model_#{name}") }

    unless model_values.include?(true)
      record.errors[attribute] << (options[:message] || 'を選択してください。')
    end
  end
end