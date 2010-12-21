module FeedBuilder
  module Controller
    def send_feed(filename, options = {}, &block)
      if Rails.env == 'development' || stale?(options)
        feed ||= yield if block_given?
        send_data(feed.to_xml, :filename => filename, :type => :atom, :disposition => 'inline')
      end
    end

    def feed_url_builder(sym, options = {}, *args)
      UrlBuilder.new(self, sym, options, *args)
    end
  end
end

class ActionController::Base
  include FeedBuilder::Controller
end
