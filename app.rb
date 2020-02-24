require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "2032ae6f9df85d324aa2fd4f3020b8dd"



# news is now a Hash you can pretty print (pp) and parse for your output

get "/" do
  view "ask"
end

get "/news" do
    results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    address = results.first.address
    @cityname = address.split(",")[0]
    @forecast = ForecastIO.forecast(lat_long[0],lat_long[1]).to_hash
    url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=76c50ac18f0b45bf9ed0df5f6787c5ae"
    @news = HTTParty.get(url).parsed_response.to_hash
    view "news"
end