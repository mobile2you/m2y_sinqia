module M2ySinqia

  class SinqiaBank < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end

    def getBanks
      response = @request.get(@url + BANKS_PATH)
      resp = SinqiaModel.new(response)
      array = []
      if !resp.obterBancos.nil?
        resp.obterBancos.each do |bank|
          array << {id: bank["nrBanco"], code: bank["nrBanco"], name: bank["nmBanco"]}
        end
      end
      array
    end

  end

end
