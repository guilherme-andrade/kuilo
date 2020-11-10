module HasSlug
  extend ActiveSupport::Concern

  included do
    before_validation :_set_slug, unless: :slug
    validates :slug, presence: true, uniqueness: { case_sensitive: false }
  end

  private

  def _set_slug
    self.slug ||= send(self.class._slug_attribute).to_s.downcase.parameterize
  end

  class_methods do
    def slug_attribute(attribute)
      @_slug_attribute = attribute
    end

    def _slug_attribute
      @_slug_attribute ||= :name
    end
  end
end
