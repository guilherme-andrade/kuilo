module ViewComponentReflex::Layout
  include ViewComponent::WithContext

  def self.included(base)
    base.extend ClassMethods
  end

  def page_reflex_tag(reflex, tag, content_or_options, options = {}, &blk)
    opts = if content_or_options.is_a? Hash
             combine_options(content_or_options, page_reflex_data_attributes(reflex))
           else
             combine_options(options, page_reflex_data_attributes(reflex))
           end
    content = content_or_options.is_a?(Hash) ? capture(&blk) : content_or_options

    content_tag(tag, content, opts, options)
  end

  def page_reflex_data_attributes(reflex)
    class_name, page_key = @page_reflex_attributes.values_at(:class_name, :key)

    action, method = reflex.to_s.split('->')

    if method.nil?
      method = action
      action = 'click'
    end

    { data: { reflex: "#{action}->#{class_name}##{method}", key: page_key } }
  end

  def layout_component_controller(*args, &blk)
    content_tag(:div, data: @page_reflex_attributes) do
      component_controller(&blk)
    end
  end

  module ClassMethods
    def with_layout_areas(areas = {})
      with_content_areas(*areas.keys.map { |area| :"#{area}_component" })
      areas.each do |area, component_class|
        _define_layout_area_methods(area, component_class)
      end
      _define_page_with_layout_module(areas)
    end

    private

    def _define_layout_area_methods(area, component_class)
      attr_reader :"#{area}_component"

      define_method(:"#{area}_present?") do
        send(:"#{area}_component").present?
      end

      define_method(:area_component_context) do
        {
          page_reflex_attributes: @page_reflex_attributes,
          layout_reflex_attributes: component_reflex_attributes
        }
      end

      define_method(:"#{area}_context") do
        (instance_variable_get(:"@#{area}_context") || {}).yield_self do |context|
          context.merge(area_component_context)
        end
      end

      define_method(area) do
        area_context = send("#{area}_context")
        area_content_component = send("#{area}_component")

        render(component_class.new(area_context)) do
          render(area_content_component.new(area_context)) if area_content_component
        end
      end
    end

    def _define_page_with_layout_module(areas)
      layout_module_name = [to_s.split('::').last, 'Methods'].join

      module_parent.const_set(layout_module_name, Module.new).tap do |layout_module|
        areas.each do |area, _area_component|
          layout_module.define_method(:"#{area}_context") do
            instance_variable_get(:"@#{area}_context") || {}
          end

          layout_module.define_method(:"#{area}_component") do
            instance_variable_get(:"@#{area}_component")
          end

          layout_module.define_method(:"show_#{area}") do
            instance_variable_set(:"@#{area}_component", element.dataset.component.safe_constantize)
          end

          layout_module.define_method(:"hide_#{area}") do
            instance_variable_set(:"@#{area}_component", nil)
          end

          layout_module.define_method(:"#{area}_shown?") do
            instance_variable_get(:"@#{area}_component").present?
          end

          layout_module.define_method(:"#{area}_hidden?") do
            instance_variable_get(:"@#{area}_component").blank?
          end

          layout_module.define_method(:"toggle_#{area}") do
            if send("#{area}_shown?")
              send("hide_#{area}")
            else
              send("show_#{area}")
            end
          end
        end

        layout_module.define_method(:layout) do |&blk|
          layout_component_class.new(layout_context) do
            capture(&blk)
          end
        end

        layout_module.define_method(:layout_component_context) do
          {
            key: layout_key,
            page_reflex_attributes: component_reflex_attributes
          }
        end

        layout_module.define_method(:layout_context) do
          layout_component_context.tap do |context|
            areas.each do |area, _|
              context[:"#{area}_context"] = send(:"#{area}_context")
              context[:"#{area}_component"] = send(:"#{area}_component")
            end
          end
        end
      end
    end
  end
end
