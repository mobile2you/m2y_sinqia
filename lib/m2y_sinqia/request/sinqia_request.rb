require "httparty"

module M2ySinqia

  class SinqiaRequest

    def initialize(username, password)
      @headers = {
        "Content-Type" => 'application/json',
        "Accept" => 'application/json'
      }
      @auth = {:username => username, :password => password}
    end

    def auth
      @auth
    end

    def get(url)
      if !url.include?("dev.")
        url.gsub!("API/", "")
      end
      puts url.to_s
      req = HTTParty.get(url, headers: @headers, basic_auth: @auth)
      req.parsed_response
    end

    def post(url, body, headers = {})
      if !url.include?("dev.")
        url.gsub!("API/", "")
      end
      puts url.to_s
      headers = @headers.merge(headers)
      req = HTTParty.post(url,
                          body: body.to_json,
                          headers: headers, basic_auth: @auth
                          )
      puts body
      req.parsed_response
    end


  end

end
