class FormComponent < ReflexComponent
  include ViewComponentReflex::Form

  attr_reader :record

  def initialize(record: nil, options: {})
    @record = record
    @options = options
  end
end
