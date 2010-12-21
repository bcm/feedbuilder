module FeedBuilder
  class UrlBuilder
    attr_reader :base_url, :html_url, :self_url

    def initialize(base_url, html_url, self_url = nil, options = {})
      @base_url = base_url
      @html_url = html_url
      if self_url.present?
        @self_url = self_url
      else
        @self_url = html_url.dup
        if @self_url =~ /\?/
          @self_url.sub!(/\?/, '.atom?')
        else
          @self_url << '.atom'
        end
      end
      @page_param = options[:page_param] || :page
      @page_size_param = options[:page_size_param] || :page_size
    end

    def first_url(page_size)
      add_params(self_url, @page_param => 1, @page_size_param => page_size)
    end

    def next_url(current_page, page_size)
      add_params(self_url, @page_param => current_page + 1, @page_size_param => page_size)
    end

    def prev_url(current_page, page_size)
      add_params(self_url, @page_param => current_page - 1, @page_size_param => page_size)
    end

    def last_url(total_pages, page_size)
      add_params(self_url, @page_param => total_pages, @page_size_param => page_size)
    end

    def add_params(url, params = {})
      unless params.empty?
        qs = params.inject([]) {|m, kv| m << "#{kv[0]}=#{kv[1]}"}
        sep = url =~ /\?/ ? '&' : '?'
        url << "#{sep}#{URI.escape(qs.join('&'))}"
      end
      url
    end
  end
end
