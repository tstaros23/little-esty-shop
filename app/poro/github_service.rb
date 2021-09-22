class GithubService
  BASE_URL = "https://api.github.com/repos/tstaros23/little-esty-shop"

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end

  def repo_name
    get_data(BASE_URL)[:name]
  end

  def contributors
    array = get_data('https://api.github.com/repos/tstaros23/little-esty-shop/contributors')
    names = []
    array.each do |hash|
      names << hash[:login]
    end
    names.join(', ')
  end
end
