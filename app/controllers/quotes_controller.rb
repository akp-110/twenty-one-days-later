require 'net/http'
require 'json'

class QuotesController < ApplicationController
  def random
    url = URI("https://zenquotes.io/api/random")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    render json: {
      quote: data[0]["q"],
      author: data[0]["a"]
    }
  rescue => e
    render json: { error: "Failed to load quote" }, status: :service_unavailable
  end
end
