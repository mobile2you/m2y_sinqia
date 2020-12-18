module M2ySinqia

  class SinqiaAddress < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end

    def getAddressHeaders
      url = address_url + USER_ADDRESS_PATH
      response = HTTParty.get(url, basic_auth: @request.auth)

      headers = {}

      token = response.headers["set-cookie"]
      if !token.nil?
        token = token.split("XSRF-TOKEN=").last.split(";").first
        puts token
        headers["X-XSRF-TOKEN"] = token
        headers["Cookie"] = "XSRF-TOKEN=#{token}"
      end
      puts headers
      headers
    end


    def getAddresses(body)
      headers = getAddressHeaders
      body[:nrInst] = getInstitution
      response = @request.post(address_url + CHECK_ADDRESS, body, headers)
      puts response
      SinqiaModel.new(response)
    end

    def address_url
      @url.gsub('8090', '8093')
    end
  end
end
