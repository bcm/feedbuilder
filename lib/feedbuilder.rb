require 'atom'
require 'active_support/core_ext/date/acts_like'
require 'active_support/core_ext/date_time/acts_like'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/object/blank'

require 'feedbuilder/provider'
require 'feedbuilder/url_builder'

module FeedBuilder
  mattr_accessor :feed_id_domain
end
