class GoogleCustomSearch
  ROOT_URL = 'https://www.googleapis.com/'

  def key
    ENV['GOOGLE_CUSTOM_SEARCH_KEY']
  end

  def cx
    ENV['GOOGLE_CUSTOM_SEARCH_CX']
  end

  def connection
    options = {
      :url => ROOT_URL,
      :ssl => { :verify => false }
    }
    @connection ||= Faraday.new(options) do |faraday|
      faraday.request :json
      faraday.adapter Faraday.default_adapter
      faraday.use FaradayMiddleware::Mashify
      faraday.use FaradayMiddleware::ParseJson
    end
  end

  def request(query)
    path = "/customsearch/v1"
    params = {alt: :json, key: key, cx: cx, q: query}
    response = connection.get do |req|
      req.headers['Content-Type'] = 'application/json'
      req.url path, params
    end
    response.body
  end

end
