module FeedBuilder
  module Provider
    mattr_accessor :feed_id_domain
    mattr_accessor :feed_id_date
    mattr_accessor :feed_id_path
    mattr_accessor :feed_id

    def build_feed(collection, url_builder, options = {}, &block)
      unless self.feed_id.present? || options.include?(:feed_id) || options.include?(:feed_id_path)
        raise ArgumentError, 'One of self.feed_id, :feed_id option or :feed_id_path option must be provided'
      end
      feed_updated = nil
      collection.each do |model|
        if feed_updated.nil? || model.updated_at > feed_updated
          feed_updated = model.updated_at
        end
      end
      Atom::Feed.new do |feed|
        feed.id = if options.include?(:feed_id)
          options[:feed_id]
        elsif options.include?(:feed_id_path)
          feed_tag_uri(options[:feed_id_path])
        else
          self.feed_id
        end
        feed.title = options[:feed_title]
        feed.updated = feed_updated
        feed.links << Atom::Link.new(:href => url_builder.html_url, :rel => :via, :type => 'text/html')
        feed.links << Atom::Link.new(:href => url_builder.self_url, :rel => :self, :type => 'application/atom+xml')
        if collection.respond_to?(:total_pages) && collection.respond_to?(:current_page)
          if collection.total_pages > 1
            feed.links << Atom::Link.new(:href => url_builder.first_url, :rel => :first)
            if collection.current_page > 1
              feed.links << Atom::Link.new(:href => url_builder.prev_url(collection.current_page), :rel => :previous)
            end
            if collection.current_page < collection.total_pages
              feed.links << Atom::Link.new(:href => url_builder.next_url(collection.current_page), :rel => :next)
            end
            feed.links << Atom::Link.new(:href => url_builder.last_url(collection.total_pages), :rel => :last)
          end
        end
        collection.each {|model| feed.entries << build_entry(model, &block)}
      end
    end

    def build_entry(model,  &block)
      Atom::Entry.new do |entry|
        entry.id = model.entry_id
        entry.title = model.entry_title if model.respond_to?(:entry_title)
        entry.published = model.respond_to?(:entry_published) ? model.entry_published : model.created_at
        entry.updated = model.respond_to?(:entry_updated) ? model.entry_updated : model.updated_at
        entry.summary = model.entry_summary if model.respond_to?(:entry_summary)
        entry.content = model.entry_content if model.respond_to?(:entry_content)
        yield(model, entry) if block_given?
      end
    end

    def feed_tag_uri(path, options = {})
      domain = options[:domain] || self.feed_id_domain || FeedBuilder.feed_id_domain
      date = options[:date] || self.feed_id_date || Date.today
      date_str = date.acts_like_date?? date.strftime("%Y-%m-%d") : date.to_s
      "tag:#{domain},#{date_str}:#{path.gsub(/\#/, '/')}"
    end
  end
end

class ActiveRecord::Base
  def self.acts_as_feed_provider(options = {})
    unless (options.include?(:feed_id_domain) && options.include?(:feed_id_path)) || options.include?(:feed_id)
      raise ArgumentError, 'Must include either :feed_id_domain and :feed_id_path or :feed_id'
    end

    extend FeedBuilder::Provider

    self.feed_id_domain = options[:feed_id_domain]
    self.feed_id_date = options[:feed_id_date]
    self.feed_id_path = options[:feed_id_path]
    self.feed_id = options[:feed_id]
  end
end
