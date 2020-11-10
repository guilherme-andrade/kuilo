class Static::FormSection < ApplicationComponent
  def initialize(title: nil, subtitle: nil)
    @title = title
    @subtitle = subtitle
  end
end
