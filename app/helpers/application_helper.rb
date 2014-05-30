module ApplicationHelper
    # A navbar entry
    def nav_entry(title, **args)
        html_class = if current_page? args then "active item" else "item" end
        link_to title, args, :class => html_class
    end

    def nav_entry(title, url)
        html_class = if current_page? url then "active item" else "item" end
        link_to title, url, :class => html_class
    end
end
