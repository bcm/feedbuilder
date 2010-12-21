Feedbuilder is a tiny utility that simplifies the process of building and delivering Atom feeds.

## Usage

    require 'rubygems'
    require 'bundler/setup'
    require 'feedbuilder'
    require 'spec/nug'

    nugs = [1, 2, 3].map {|id| Nug.new(id, "Nug #{id}")}
    url_builder = FeedBuilder::UrlBuilder.new('http://test.host/', 'http://test.host/nugs')
    feed = Nug.build_feed(nugs, url_builder, :feed_title => "Bucket o' nugs") do |nug, entry|
      entry.links << Atom::Link.new(:href => "/nugs/#{nug.id}", :rel => :alternate, :type => 'text/html')
    end

    # feed.to_xml outputs:

    <?xml version="1.0" encoding="UTF-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <id>tag:maz.org,2010-12-21:/nugs</id>
      <title>Bucket o' nugs</title>
      <updated>2010-12-21T16:57:21-05:00</updated>
      <link rel="via" type="text/html" href="http://test.host/nugs"/>
      <link rel="self" type="application/atom+xml" href="http://test.host/nugs.atom"/>
      <entry>
        <id>tag:maz.org,2010-12-21:/nugs/1</id>
        <summary>A nug named Nug 1</summary>
        <updated>2010-12-21T16:57:21-05:00</updated>
        <published>2010-12-21T16:57:21-05:00</published>
        <link rel="alternate" type="text/html" href="http://test.host/nugs/1"/>
        <content type="html">&lt;p&gt;A nug named Nug 1&lt;/p&gt;</content>
      </entry>
      <entry>
        <id>tag:maz.org,2010-12-21:/nugs/2</id>
        <summary>A nug named Nug 2</summary>
        <updated>2010-12-21T16:57:21-05:00</updated>
        <published>2010-12-21T16:57:21-05:00</published>
        <link rel="alternate" type="text/html" href="http://test.host/nugs/2"/>
        <content type="html">&lt;p&gt;A nug named Nug 2&lt;/p&gt;</content
      </entry>
      <entry>
        <id>tag:maz.org,2010-12-21:/nugs/3</id>
        <summary>A nug named Nug 3</summary>
        <updated>2010-12-21T16:57:21-05:00</updated>
        <published>2010-12-21T16:57:21-05:00</published>
        <link rel="alternate" type="text/html" href="http://test.host/nugs/3"/>
        <content type="html">&lt;p&gt;A nug named Nug 3&lt;/p&gt;</content>
      </entry>
    </feed>

## Copyright

Copyright (c) 2010 Brian Moseley. See LICENSE for details.
