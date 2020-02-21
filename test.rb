require "httparty"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=76c50ac18f0b45bf9ed0df5f6787c5ae"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

pp news