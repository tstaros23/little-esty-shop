require 'faraday'
require 'json'

class GithubService

  def self.repo_name
    response = Faraday.get 'https://api.github.com/repos/tstaros23/little-esty-shop'
    parsed = JSON.parse(response.body, symbolize_names: true) #string to hash object
    parsed[:name]
  end
end
