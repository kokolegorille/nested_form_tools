module NestedFormTools
  module ViewHelpers
    CHILD_INDEX = "NEW_RECORD"
    
    def nested_fields_for(association, f, options = {}, &block)
      if block_given?
        f.fields_for association do |nested_form|
          yield(nested_form)
        end
      else
        options = {
          partial: association.to_s.singularize + '_fields',
          nested_partial: "nested_fieldset",
          container_id: association.to_s,
          title: association.to_s.underscore.humanize
        }.merge(options)
        
        if association.to_s.singularize == association.to_s
          # has_one
          f.fields_for association do |nested_form|
            render(partial: options[:partial], locals: { f: nested_form })
          end
        else
          # has_many
          html_options = {
            container_id: options[:container_id],
            title: options[:title]
          }
          render(partial: options[:nested_partial], locals: { 
            f: f,
            association: association,
            partial: options[:partial],
            html_options: html_options 
          })
        end
      end
    end
    
    def generate_template(association, f, options = {})
      escape_javascript(generate_html(association, f, options))
    end
    
    def link_to_add_nested(association, options = {})
      options = {
        caption: "add #{ association.to_s.singularize.underscore.humanize }"
      }.merge(options)
      jstemplate = options.delete(:jstemplate) || association.to_s.singularize
      container_id = options[:container_id] || association.to_s
      add_link(jstemplate, container_id, options)
    end
    
    def link_to_remove_nested(f, options = {})
      options[:is_new] = f.object.new_record?
        
      html = ""
      html << f.hidden_field(:_destroy) unless options[:is_new]
      html << remove_link(options)
      html.html_safe
    end
    
    private
    def add_link(association, target, options = {})
      options = { caption: "add" }.merge(options)
      link_to options[:caption], "#", 
        class: "add_child",
        :"data-association" => association, 
        :"data-target" => target
    end
    
    def remove_link(options = {})
      options = { caption: "delete" }.merge(options)
      link_to options[:caption], "#", 
        class: (options[:is_new] ? "remove_child dynamic" : "remove_child existing")
    end
    
    def generate_html(association, f, options = {})
      options = {
        object: f.object.class.reflect_on_association(association).klass.new,
        partial: association.to_s.singularize + "_fields"
      }.merge(options)
      f.fields_for(association, options[:object], child_index: CHILD_INDEX) do |nested_form|
        render partial: options[:partial], locals: { f: nested_form }
      end
    end
  end
end