module M2ySinqia

  class SinqiaDocuments < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)

      if @url.include?("8090")
        @url.gsub!("8090", "8091")
      end

    end


    def addKit(body)
      response = @request.post(@url + ADD_KIT, body)
      puts response
      SinqiaModel.new(response)
    end


    def checkKit(params)
      response = @request.post(@url + CHECK_KIT, params)
      puts response
      SinqiaModel.new(response)
    end

    def sendProposal(params)
      response = @request.post(@url + SEND_PROPOSAL, params)
      puts response
      SinqiaModel.new(response)
    end

  end
end
