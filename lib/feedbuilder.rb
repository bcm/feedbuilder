require 'action_controller'
require 'active_record'
require 'atom'

require 'feedbuilder/controller'
require 'feedbuilder/provider'
require 'feedbuilder/url_builder'

module Feedbuilder
  mattr_accessor :feed_id_domain
end
