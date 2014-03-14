require 'spec_helper'

describe FeedBuilder::Provider do
  describe "#build_feed" do
    it "builds a feed" do
      feed.should_not be_nil
    end

    it "sets id to the global feed id" do
      feed_id_path = Nug.feed_id_path
      Nug.feed_id_path = nil
      Nug.feed_id = 'foobar'
      feed(:feed_id => nil).id.should == Nug.feed_id
      Nug.feed_id = nil
      Nug.feed_id_path = feed_id_path
    end

    it "sets id as provided" do
      id = "foo.com,1999-12-31/nugs"
      feed(:feed_id => id).id.should == id
    end

    it "sets id as per the provided path" do
      path = '/path/to/nugs'
      feed(:feed_id => nil, :feed_id_path => path).id.should == Nug.feed_tag_uri(path)
    end

    it "sets title as provided" do
      feed.title.should == @title
    end

    it "sets updated as provided" do
      feed.updated.should == @nugs.last.updated_at
    end

    it "adds the correct number of links" do
      feed.links.should have_exactly(2).links
    end

    it "adds via link" do
      via_link.should_not be_nil
    end

    it "sets via link to text/html" do
      via_link.type.should == 'text/html'
    end

    it "sets self link" do
      self_link.should_not be_nil
    end

    it "sets self link to application/atom+xml" do
      self_link.type.should == 'application/atom+xml'
    end

    it "adds the correct number of entries" do
      feed.should have_exactly(@nugs.size).entries
    end
  end

  describe "#build_entry" do
    it "builds an entry" do
      entry.should_not be_nil
    end

    it "sets id to Nug#entry_id" do
      entry.id.should == @nug.entry_id
    end

    it "sets title to Nug#name" do
      entry.title.should == @nug.name
    end

    it "sets published to Nug#created_at" do
      entry.published.should == @nug.created_at
    end

    it "sets updated to Nug#updated_at" do
      entry.updated.should == @nug.updated_at
    end

    it "sets text summary" do
      entry.summary.should be_a(Atom::Content::Text)
    end

    it "sets html content" do
      entry.content.should be_a(Atom::Content::Html)
    end
  end
end

def feed(options = {})
  @title = "Bucket o' nugs"
  @nugs = [1, 2, 3].map {|id| Nug.new(id, "Nug #{id}")}
  options = {:feed_title => @title}.merge(options)
  if options.include?(:feed_id)
    options.delete(:feed_id) if options[:feed_id].nil?
  else
    options[:feed_id] = Nug.feed_tag_uri(Nug.feed_id_path)
  end
  Nug.build_feed(@nugs, FeedBuilder::UrlBuilder.new('/', '/nugs'), options)
end

def entry
  @nug = Nug.new(1, "Fug slug")
  Nug.build_entry(@nug) do |nug, entry|
    entry.title = nug.name
  end
end

def via_link
  feed.links.detect {|l| l.rel == :via}
end

def self_link
  feed.links.detect {|l| l.rel == :self}
end
