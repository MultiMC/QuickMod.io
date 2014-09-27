module ApplicationHelper
    def nav_entry(*args, &block)
        title = args.shift if block.nil?
        html_class = if current_page?(*args[0]) then
                         'active item'
                     else
                         'item'
                     end
        options    = args.extract_options!
        args.unshift title if block.nil?
        if options[:class].nil?
            options[:class] = html_class
        else
            options[:class] += " #{html_class}"
        end
        if block.nil?
            link_to *args, options
        else
            link_to *args, options, &block
        end
    end

    def placeholder(x, y, *options)
        image_tag "http://placehold.it/#{x}x#{y}", *options
    end

end
