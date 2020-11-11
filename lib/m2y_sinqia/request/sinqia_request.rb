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


    def get(url)
      if !url.include?("dev.")
        url.gsub!("API/", "")
      end
      puts url.to_s
      req = HTTParty.get(url, headers: @headers, basic_auth: @auth)
      req.parsed_response
    end

    def post(url, body)
      if !url.include?("dev.")
        url.gsub!("API/", "")
      end
      puts url.to_s
      req = HTTParty.post(url,
                          body: body.to_json,
                          headers: @headers, basic_auth: @auth
                          )
      puts body
      req.parsed_response
    end

  end

end
