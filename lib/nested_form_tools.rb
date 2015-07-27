require 'nested_form_tools/view_helpers'

module NestedFormTools
  class Engine < ::Rails::Engine
    
    # config.before_initialize do
    #   config.action_view.javascript_expansions[:nested_form_tools] = %w(nested_form_tools)
    # end
    
    initializer "nested_form_tools.initialize" do |app|
      ActionView::Base.send :include, NestedFormTools::ViewHelpers
    end
    
  end
end
