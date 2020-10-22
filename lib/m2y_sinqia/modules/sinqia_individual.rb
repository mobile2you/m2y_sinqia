module M2ySinqia

  class SinqiaIndividual < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end

    def findPerson(cpf)
      response = @request.get(@url + CUSTOMERS_PATH + "?nrCpfcnpjUsu=#{cpf}")
      begin
        SinqiaModel.new(response["clientes"].select{|x| x["nrCpfCnpjCli"] == cpf}.first)
      rescue
        nil
      end
    end

  end

end
