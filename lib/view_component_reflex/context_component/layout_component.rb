require 'view_component_reflex/context_component/base_component'

class ViewComponentReflex::ContextComponent::LayoutComponent < ViewComponentReflex::ContextComponent::BaseComponent
  def layout_component_controller(tag, options = {}, &blk)
    content_tag(tag, combine_options(options.delete(:container) || {}, data: context.app_data_attributes)) do
      component_controller(options, &blk)
    end
  end

  class << self
    def with_layout_areas(areas = {})
      with_content_areas(*areas.keys.map { |area| :"#{area}_component" })
      areas.each do |area, component_class|
        _define_layout_area_methods(area, component_class)
      end
      _define_page_with_layout_module(areas)
    end

    private

    def _define_layout_area_methods(area, component_class)
      define_method(:"#{area}_present?") do
        send(:"#{area}_component").present?
      end

      define_method(:"#{area}_component") do
        context.send("#{area}_component") if context.respond_to?("#{area}_component")
      end

      define_method(:"#{area}_context") do
        context.send("#{area}_context") if context.respond_to?("#{area}_context")
      end

      define_method(area) do
        area_component = send("#{area}_component")
        area_context = send("#{area}_context")
        return render_with_context(component_class) unless area_component

        render_with_context(component_class) { render_with_context(area_component, area_context || {}) }
      end
    end

    def _define_page_with_layout_module(areas)
      layout_module_name = [to_s.split('::').last, 'Methods'].join

      module_parent.const_set(layout_module_name, Module.new).tap do |layout_module|
        areas.each do |area, _area_component|
          layout_module.define_method(:"#{area}_context") do
            instance_variable_get(:"@#{area}_context")
          end

          layout_module.define_method(:"#{area}_component") do
            instance_variable_get(:"@#{area}_component")
          end

          layout_module.define_method(:"show_#{area}") do
            context.add("#{area}_component": element.dataset.component.safe_constantize)
            context.add("#{area}_context": JSON.parse(element.dataset.context)) if element.dataset.context
          end

          layout_module.define_method(:"hide_#{area}") do
            context.remove(:"#{area}_component", :"#{area}_context")
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

        layout_module.define_method(:render_layout_with_context) do |&blk|
          render_with_context layout_component_class do
            capture(&blk)
          end
        end
      end
    end
  end
end
