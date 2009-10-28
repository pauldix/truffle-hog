module TruffleHog
  VERSION = "0.0.3"
  
  def self.parse_feed_urls(html, favor = :all)
    rss_links  = scan_for_tag(html, "rss")
    atom_links = scan_for_tag(html, "atom")

    case favor
    when :all
      (rss_links + atom_links).uniq
    when :rss
      rss_links.empty? ? atom_links : rss_links
    when :atom
      atom_links.empty? ? rss_links : atom_links
    end
  end
  
  def self.scan_for_tag(html, type)
    urls(html, "link", type) + urls(html, "a", type)
  end
  
  def self.urls(html, tag, type)
    tags = html.scan(/(<#{tag}.*?>)/).flatten
    feed_tags = collect(tags, type)
    feed_tags.map do |tag|
      matches = tag.match(/.*href=['"](.*?)['"].*/)
      if matches.nil?
        url = ""
      else
        url = matches[1]
      end
      url =~ /^http.*/ ? url : nil
    end.compact
  end
  
  def self.collect(tags, type)
    tags.collect {|t| t if feed?(t, type)}.compact
  end
  
  def self.feed?(html, type)
    html =~ /.*type=['"]application\/#{type}\+xml['"].*/
  end
end