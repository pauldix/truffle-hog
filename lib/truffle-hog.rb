module TruffleHog
  VERSION = "0.0.1"
  
  def self.parse_feed_urls(html, favor = :all)
    rss_links  = []
    atom_links = []
    
    rss_links  = (scan_for_tag(html, "a", "rss") + scan_for_tag(html, "link", "rss")).flatten.uniq
    atom_links = (scan_for_tag(html, "a", "atom") + scan_for_tag(html, "link", "atom")).flatten.uniq

    case favor
    when :all
      (rss_links + atom_links).uniq
    when :rss
      rss_links.empty? ? atom_links : rss_links
    when :atom
      atom_links.empty? ? rss_links : atom_links
    end
  end
  
  def self.scan_for_tag(html, tag, type)
    href_first = html.scan(/<#{tag}.*href\=['"](.*?)['"].*type\=['"]application\/#{type}\+xml['"].*?>/)
    return href_first unless href_first.empty?
    
    html.scan(/<#{tag}.*type\=['"]application\/#{type}\+xml['"].*href=['"](.*?)['"].*?>/)
  end
end