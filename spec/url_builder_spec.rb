require 'spec_helper'

describe FeedBuilder::UrlBuilder do
  subject do
    FeedBuilder::UrlBuilder.new('http://example.com', 'http://example.com/foobar.html?baz=quux',
                                'http://example.com/foobar.atom?baz=quux')
  end

  describe '#first_url' do
    it 'has the correct path' do
      subject.first_url(10).path.should eq('/foobar.atom')
    end

    it 'has the correct baz param' do
      subject.first_url(10).query_values['baz'].should eq('quux')
    end

    it 'has the correct page param' do
      subject.first_url(10).query_values['page'].should eq('1')
    end

    it 'has the correct per_page param' do
      subject.first_url(10).query_values['per_page'].should eq('10')
    end
  end

  describe '#next_url' do
    it 'has the correct path' do
      subject.next_url(1, 10).path.should eq('/foobar.atom')
    end

    it 'has the correct baz param' do
      subject.next_url(1, 10).query_values['baz'].should eq('quux')
    end

    it 'has the correct page param' do
      subject.next_url(1, 10).query_values['page'].should eq('2')
    end

    it 'has the correct per_page param' do
      subject.next_url(1, 10).query_values['per_page'].should eq('10')
    end
  end

  describe '#prev_url' do
    it 'has the correct path' do
      subject.prev_url(2, 10).path.should eq('/foobar.atom')
    end

    it 'has the correct baz param' do
      subject.prev_url(2, 10).query_values['baz'].should eq('quux')
    end

    it 'has the correct page param' do
      subject.prev_url(2, 10).query_values['page'].should eq('1')
    end

    it 'has the correct per_page param' do
      subject.prev_url(2, 10).query_values['per_page'].should eq('10')
    end
  end

  describe '#last_url' do
    it 'has the correct path' do
      subject.last_url(5, 10).path.should eq('/foobar.atom')
    end

    it 'has the correct baz param' do
      subject.last_url(5, 10).query_values['baz'].should eq('quux')
    end

    it 'has the correct page param' do
      subject.last_url(5, 10).query_values['page'].should eq('5')
    end

    it 'has the correct per_page param' do
      subject.last_url(5, 10).query_values['per_page'].should eq('10')
    end
  end
end
