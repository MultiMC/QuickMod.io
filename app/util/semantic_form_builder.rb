class SemanticFormBuilder < ActionView::Helpers::FormBuilder

    include ActionView::Helpers::TagHelper
    include Haml::Helpers

    def field(options = {}, &block)
        add_option(:class, 'field', options)
        content_tag(:div, block_contents(block), options)
    end

    def text_field(id, rails: {}, semantic: {})
        field_wrapper(id, super(id, rails), semantic)
    end

    def text_area(id, rails: {}, semantic: {})
        field_wrapper(id, super(id, rails), semantic)
    end

    def two_fields(options = {}, &block)
        multiple_fields('two', options, &block)
    end

    def three_fields(options = {}, &block)
        multiple_fields('three', options, &block)
    end

    def four_fields(options = {}, &block)
        multiple_fields('four', options, &block)
    end

    def five_fields(options = {}, &block)
        multiple_fields('five', options, &block)
    end

    private

    def field_wrapper(id, contents, options = {})
        add_option(:class, 'field', options)
        options[:data]  ||= {}
        options[:data][:form_field] = id
        wrapper_class = 'ui input'
        siblings      = content_tag(:div, '', class: 'ui red pointing label hidden', data: {error_container: true})
        if options[:required]
            siblings << content_tag(:div, content_tag(:i, '', class: 'icon asterisk'), class: 'ui corner label')
        end
        content_tag(:div, content_tag(:div, contents + siblings, class: wrapper_class), options)
    end

    def add_option(type, css_class, options = {})
        if options[type].nil?
            options[type] = css_class
        else
            options[type] << ' ' << css_class
        end
    end

    def multiple_fields(css_class, options = {}, &block)
        add_option(:class, css_class, options)
        options[:class] << ' ui fields'
        content_tag(:div, block_contents(block), class: 'ui two fields')
    end

    def block_contents(block)
        # noinspection RubyArgCount
        eval('self', block.binding).capture(&block)
    end

end