require 'addressable/uri'

module FeedBuilder
  class UrlBuilder
    attr_reader :base_url, :html_url, :self_url

    def initialize(base_url, html_url, self_url = nil, options = {})
      @base_url = Addressable::URI.parse(base_url)
      @html_url = Addressable::URI.parse(html_url)
      if self_url.present?
        @self_url = Addressable::URI.parse(self_url)
      else
        @self_url = @html_url.dup
        @self_url.path = "#{@self_url.path}.atom"
      end
      @page_param = options[:page_param] || :page
      @per_page_param = options[:per_page_param] || :per_page
    end

    def first_url(per_page)
      self_url.dup.tap do |copy|
        copy.query_values = hashify_query_values(copy).
          merge(@page_param.to_s => '1', @per_page_param.to_s => per_page.to_s)
      end
    end

    def next_url(current_page, per_page)
      self_url.dup.tap do |copy|
        copy.query_values = hashify_query_values(copy).
          merge(@page_param.to_s => (current_page + 1).to_s, @per_page_param.to_s => per_page.to_s)
      end
    end

    def prev_url(current_page, per_page)
      self_url.dup.tap do |copy|
        copy.query_values = hashify_query_values(copy).
          merge(@page_param.to_s => (current_page - 1).to_s, @per_page_param.to_s => per_page.to_s)
      end
    end

    def last_url(total_pages, per_page)
      self_url.dup.tap do |copy|
        copy.query_values = hashify_query_values(copy).
          merge(@page_param.to_s => total_pages.to_s, @per_page_param.to_s => per_page.to_s)
      end
    end

  private
    def hashify_query_values(uri)
      (uri.query_values(Array) || []).each_with_object({}) { |(key, val), m| m[key] ||= []; m[key] << val}
    end
  end
end
