require 'open-uri'
require 'json'

class ZenquotesService
  API_URL = 'https://zenquotes.io/api/random'

  def self.get_quote
    response = URI.open(API_URL).read
    json = JSON.parse(response)

    # API returns an array with a hash
    {
      quote: json.first["q"],
      author: json.first["a"]
    }
  rescue OpenURI::HTTPError => e
    Rails.logger.error("ZenQuotes API error: #{e.message}")
    nil
  end
end
