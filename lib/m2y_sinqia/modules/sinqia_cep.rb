module M2ySinqia

  class SinqiaCep < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end

    def ceps(body)
      response = @request.get("https://viacep.com.br/ws/#{body[:CEP]}/json")
      person = SinqiaModel.new(response)
      person
    end

  end
end
