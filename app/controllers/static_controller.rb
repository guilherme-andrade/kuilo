# frozen_string_literal: true

class StaticController < ApplicationController
  def home; end

  def manifest
    render(partial: 'application/site.manifest.json', layout: false, formats: %i[json])
  end
end
