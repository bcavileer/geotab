module Geotab
  class Client
    DEFAULT_PATH = "my.geotab.com"

    def authenticate(username, password, database=nil, custom_path)
      @custom_path = custom_path

      response = RestClient::Request.execute({
        url: authentication_url,
        method: :get,
        verify_ssl: false,
        headers: { params: { userName: username, password: password, database: database }}
      })
      result = MultiJson.load(response.body)

      if result.has_key?("error")
        raise IncorrectCredentialsError, result["error"]["errors"].first["message"]
      else
        set_path(result["result"]["path"])
        set_credentials(result["result"]["credentials"].merge("path" => @path))
      end
    end

    def set_credentials(credentials)
      @credentials = credentials
      @path = credentials["path"]
      @credentials
    end

    def credentials
      "{'database':'#{@credentials['database']}','userName':'#{@credentials['userName']}','sessionId':'#{@credentials['sessionId']}'}"
    end

    def path
      @path
    end

    def authentication_url
      "https://#{initial_path}/apiv1/Authenticate"
    end

    def initial_path
      @custom_path || DEFAULT_PATH
    end

    def set_path path
      if path == "ThisServer"
        @path = initial_path
      else
        @path = path
      end
    end
  end
end
