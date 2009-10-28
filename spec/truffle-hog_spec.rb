require File.dirname(__FILE__) + '/spec_helper'

describe "parsing html" do
  before(:all) do
    @html = File.read(File.dirname(__FILE__) + "/pauldix_net.html")
  end
  
  it "parses all feed urls" do
    TruffleHog.parse_feed_urls(@html).should == ["http://www.pauldix.net/in_head/index.rdf", "http://www.pauldix.net/in_head/rss.xml", "http://feeds.feedburner.com/PaulDixExplainsNothing", "http://feeds.feedburner.com/PaulDixExplainsNothing/in_body/rss", "http://www.pauldix.net/in_head/atom.xml", "http://feeds.feedburner.com/PaulDixExplainsNothing/in_body/atom"]
  end
  
  it "parses rss feeds from the link tags in head" do
    feed_urls = TruffleHog.parse_feed_urls(@html, :rss)
    feed_urls.should include("http://www.pauldix.net/in_head/index.rdf")
    feed_urls.should include("http://www.pauldix.net/in_head/rss.xml")
    feed_urls.should_not include("http://www.pauldix.net/in_head/atom.xml")
    feed_urls.should_not include("http://feeds.feedburner.com/PaulDixExplainsNothing/in_body/atom")
  end
  
  it "parses atom feeds from the link tags in head" do
    feed_urls = TruffleHog.parse_feed_urls(@html, :atom)
    feed_urls.should include("http://www.pauldix.net/in_head/atom.xml")
    feed_urls.should_not include("http://www.pauldix.net/in_head/index.rdf")
    feed_urls.should_not include("http://www.pauldix.net/in_head/rss.xml")
  end
  
  it "parses rss feeds from the body" do
    feed_urls = TruffleHog.parse_feed_urls(@html, :rss)
    feed_urls.should include("http://feeds.feedburner.com/PaulDixExplainsNothing/in_body/rss")
    feed_urls.should_not include("http://feeds.feedburner.com/PaulDixExplainsNothing/in_body/atom")
  end

  it "parses atom feeds from the body" do
    feed_urls = TruffleHog.parse_feed_urls(@html, :atom)
    feed_urls.should include("http://feeds.feedburner.com/PaulDixExplainsNothing/in_body/atom")
    feed_urls.should_not include("http://feeds.feedburner.com/PaulDixExplainsNothing/in_body/rss")
  end
  
  it "returns atom feeds if rss is favored, but none are found"
  it "returns rss feeds if atom is favored, but none are found"
  
  describe "odd regressions" do
    it "doesn't go into an infinite loop on this input" do
      input = File.read("#{File.dirname(__FILE__)}/infinite.html")
      feed_urls = TruffleHog.parse_feed_urls(input)
      feed_urls.should == ["http://feeds.feedburner.com/cryptload"]
    end
  end
end
