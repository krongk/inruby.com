xml.instruct!
xml.urlset( "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
  "xmlns:image" => "http://www.google.com/schemas/sitemap-image/1.1",
  "xsi:schemaLocation" => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd",
  "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9",
  "xmlns:video" => "http://www.google.com/schemas/sitemap-video/1.1", 
  "xmlns:geo" => "http://www.google.com/geo/schemas/sitemap/1.0",
  "xmlns:news" => "http://www.google.com/schemas/sitemap-news/0.9", 
  "xmlns:mobile" => "http://www.google.com/schemas/sitemap-mobile/1.0",
  "xmlns:xhtml" => "http://www.w3.org/1999/xhtml") do
  xml.url do
    xml.loc "http://www.inruby.com"
    xml.lastmod Time.now
    xml.changefreq "always"
    xml.priority 1.0
  end
  @pages_to_visit.each do |item|
    xml.url do
      xml.loc "http://www.inruby.com#{item[:url]}"
      xml.lastmod item[:updated_at]
      xml.changefreq "weekly"
      xml.priority 0.8
    end
  end
end