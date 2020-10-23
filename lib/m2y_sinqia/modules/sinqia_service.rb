module M2ySinqia

  class SinqiaService < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end

    def p2pTransfer(body)
      if !checkFav(body)
        addFav(body)
      end

      #fix cdt_params
      sinqia_body = {}
      sinqia_body[:idTitul] = 'C'

      sinqia_body[:cdCta] = body[:cdCta]
      sinqia_body[:nrAgen] = body[:nrAgen]
      sinqia_body[:vlLanc] = body[:value]
      sinqia_body[:dtLanc] = Time.now.strftime("%Y%m%d")
      sinqia_body[:tpTransf] = 1
      sinqia_body[:tpCtaFav] = 'CC'
      sinqia_body[:nrSeqDes] = 0
      sinqia_body[:cdOrigem] = 24556
      sinqia_body[:nrDocCre] = 9
      sinqia_body[:cdFin] = 1
      sinqia_body[:nrSeq] = 0
      sinqia_body[:dsHist] = ''
      sinqia_body[:dsHistC] = ''
      sinqia_body[:nrBcoDes] = body[:beneficiary][:bankId]
      sinqia_body[:nrCpfCnpj] = body[:beneficiary][:docIdCpfCnpjEinSSN]
      sinqia_body[:nrAgeDes] = body[:beneficiary][:agency]
      sinqia_body[:nrCtaDes] = body[:beneficiary][:account]
      sinqia_body[:nmFavore] = body[:beneficiary][:name]
      sinqia_body[:nrInst] = getInstitution

      puts sinqia_body

      response = @request.post(@url + TRANSFER_PATH, sinqia_body)

      puts response
      transferResponse = SinqiaModel.new(response)

      if transferResponse && transferResponse.efetuaLancamentoTransferencia == 0
        transferResponse.id = Time.now.to_i
        transferResponse.statusCode = 200
        transferResponse.transactionCode = Time.now.to_i
        # transferResponse.content = transferResponse
      end
      transferResponse
    end




  end
end
