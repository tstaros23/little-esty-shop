require 'faraday'
require 'json'

class RepoName

  def self.fetched_name
    response = Faraday.get 'https://api.github.com/repos/tstaros23/little-esty-shop'
    parsed = JSON.parse(response.body, symbolize_names: true) #string to hash object
    parsed[:name]
    require "pry"; binding.pry
  end
end
require "pry"; binding.pry
