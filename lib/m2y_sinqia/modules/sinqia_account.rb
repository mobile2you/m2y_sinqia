module M2ySinqia

  class SinqiaAccount < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end

    def getAccounts(id)
      nrinst = getInstitution
      response = @request.get(@url + ACCOUNT_PATH + "?nrCliente=#{id}&nrInst=#{nrinst}")
      p response
      account = SinqiaModel.new(response["contas"].first)
      #fixing cdt_fields
      if !account.nil? && !account.cdCta.nil?
        account.saldoDisponivelGlobal = account.vlSdds
        account.idPessoa = account.cdCta
        account.idStatusConta = 0
        account.id = account.cdCta
      end
      account
    end

    def findAccount(params)
      params[:nrSeq] = 0
      params[:nrInst] = getInstitution
      response = @request.post(@url + INDIVIDUAL_PATH, params)
      SinqiaModel.new(response)
    end


    def getTransactions(params)
      params[:nrSeq] = 0
      params[:nrInst] = getInstitution
      if !params[:page].nil? && params[:page] > 0
        transactions = []
      else
        response = @request.post(@url + EXTRACT_PATH, params)
        transactions = response["consultaLancamento"]
      end
      # fixing cdt_fields
      if !transactions.nil?
        transactions.each do |transaction|
          transaction["dataOrigem"] = transaction["dtLanc"]
          transaction["descricaoAbreviada"] = transaction["dsLanc"]
          transaction["idEventoAjuste"] = transaction["idTrans"]
          transaction["codigoMCC"] = transaction["idTrans"]
          transaction["nomeFantasiaEstabelecimento"] = transaction["dsLanc"]
          transaction["valorBRL"] = transaction["vlLanc"].to_f #/100.0
          transaction["flagCredito"] = transaction["tpSinal"] == "C" ? 1 : 0
        end
      end
      transactions
    end

  end
end
