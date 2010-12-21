module FeedBuilder
  class UrlBuilder
    def initialize(controller, sym, options = {}, *args)
      @controller = controller
      @sym = sym
      @page_param = options[:page_param] || :page
      @page_size_param = options[:page_size_param] || :page_size
      @args = args
    end

    def base_url
      @controller.send(root_url)
    end

    def self_url
      @controller.send(@sym, *(@args.dup << {:format => :atom}))
    end

    def html_url
      @controller.send(@sym, *@args)
    end

    def first_url(page_size)
      @controller.send(@sym, *(clone_args(:format => :atom, @page_param => 1, @page_size_param => page_size)))
    end

    def next_url(current_page, page_size)
      @controller.send(@sym, *(clone_args(:format => :atom, @page_param => current_page + 1,
        @page_size_param => page_size)))
    end

    def prev_url(current_page, page_size)
      @controller.send(@sym, *(clone_args(:format => :atom, @page_param => current_page - 1,
        @page_size_param => page_size)))
    end

    def last_url(total_pages, page_size)
      @controller.send(@sym, *(clone_args({:format => :atom, @page_param => total_pages,
        @page_size_param => page_size})))
    end

    def clone_args(*addl_args)
      @args.dup.concat(addl_args)
    end
  end
end
