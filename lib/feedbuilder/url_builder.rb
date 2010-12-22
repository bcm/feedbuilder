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
      @per_page_param = options[:per_page_param] || :per_page
    end

    def first_url(per_page)
      add_params(self_url, @page_param => 1, @per_page_param => per_page)
    end

    def next_url(current_page, per_page)
      add_params(self_url, @page_param => current_page + 1, @per_page_param => per_page)
    end

    def prev_url(current_page, per_page)
      add_params(self_url, @page_param => current_page - 1, @per_page_param => per_page)
    end

    def last_url(total_pages, per_page)
      add_params(self_url, @page_param => total_pages, @per_page_param => per_page)
    end

    def add_params(url, params = {})
      copy = url.dup
      unless params.empty?
        qs = params.inject([]) {|m, kv| m << "#{kv[0]}=#{kv[1]}"}
        sep = copy =~ /\?/ ? '&' : '?'
        copy << "#{sep}#{URI.escape(qs.join('&'))}"
      end
      copy
    end
  end
end
