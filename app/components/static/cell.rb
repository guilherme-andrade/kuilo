class Static::Cell < ApplicationComponent
  with_content_areas :controls

  attr_reader :title

  def initialize(title: '')
    @title = title
  end
end
