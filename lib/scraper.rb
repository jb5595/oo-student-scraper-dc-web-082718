require 'open-uri'
require 'pry'

class Scraper



  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    profiles = doc.css(".student-card")
    students = []
    # profile profile = doc.css(".student-card").first
    profiles.each do |profile|
      name = profile.css(".student-name").text
      location = profile.css(".student-location").text
      link = profile.css("a").attribute("href").value
      students << {name: name, location: location, profile_url: link}
    end
    students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
   profile_page = Nokogiri::HTML(open(profile_url))
   links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
   links.each do |link|
     if link.include?("linkedin")
       student[:linkedin] = link
     elsif link.include?("github")
       student[:github] = link
     elsif link.include?("twitter")
       student[:twitter] = link
     else
       student[:blog] = link
     end
   end
   # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
   # # if profile_page.css(".social-icon-container").children.css("a")[0]
   # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
   # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
   # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
   student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
   student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

   student


  end

end
