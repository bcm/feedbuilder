feedbuilder extends Rails to simplify the process of building and delivering Atom feeds based on collections of ActiveRecord models.

## Usage

    require 'feedbuilder'
    require 'will_paginate' # to get paging links

    FeedBuilder.feed_id_domain = 'maz.org'

    class Nug < ActiveRecord::Base
      acts_as_feed_provider

      def entry_title
        name # a persistent attribute
      end

      def entry_content
        Atom::Content::Html.new("<p>A nug named #{name}</p>")
      end
    end

    class NugController < ApplicationController
      def index
        respond_to do |format|
          format.atom do
            nugs = Nug.paginate(:page => params[:page], :page_size => params[:page_size])
            send_feed("nugs.atom", :etag => nugs) do
              Nug.build_feed(nugs, feed_url_builder(:nugs_url), :feed_title => "Bucket o' nugs") do |nug, entry|
                 entry.id = Nug.feed_tag_uri(nug_path(nug), :date => nug.created_at)
                 entry.links << Atom::Link.new(:href => nug_url(nug), :rel => :alternate, :type => 'text/html')
              end
            end
          end
        end
      end
    end
