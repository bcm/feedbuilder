class Nug
  extend FeedBuilder::Provider

  # set domain and path here rather than a static feed id so that we can use them to compute entry ids as well

  self.feed_id_domain = 'maz.org'
  self.feed_id_path = '/nugs'

  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
    @created_at = DateTime.now
    @updated_at = DateTime.now
  end

  # created_at and updated_at are used to set the entry's published and updated attributes since entry_published
  # and entry_updated methods aren't defined

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

  def entry_id
    self.class.feed_tag_uri("#{self.class.feed_id_path}/#{self.id}", :date => self.created_at)
  end

  def entry_summary
    Atom::Content::Text.new("A nug named #{self.name}")
  end

  def entry_content
    Atom::Content::Html.new("<p>A nug named #{self.name}</p>")
  end
end
