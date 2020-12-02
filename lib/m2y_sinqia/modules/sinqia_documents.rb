module M2ySinqia

  class SinqiaDocuments < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end

    def addKit(body)
      response = @request.post(documents_url + ADD_KIT, body)
      puts response
      SinqiaModel.new(response)
    end

    def checkKit(params)
      response = @request.post(documents_url + CHECK_KIT, params)
      puts response
      SinqiaModel.new(response)
    end

    def sendProposal(params)
      response = @request.post(documents_url + SEND_PROPOSAL, params)
      puts response
      SinqiaModel.new(response)
    end

    def documents_url
      @url.gsub('8090', '8091')
    end
  end
end
