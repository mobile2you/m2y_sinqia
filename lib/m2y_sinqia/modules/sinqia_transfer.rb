module M2ySinqia

  class SinqiaTransfer < SinqiaModule

    def initialize(access_key, secret_key, env)
      startModule(access_key, secret_key, env)
    end


    def bankTransfers(body, is_ted, date = nil)
      if !checkFav(body)
        addFav(body)
      end

      #fix cdt_params
      sinqia_body = {}
      sinqia_body[:idTitul] = 'C'

      sinqia_body[:cdCta] = body[:cdCta]
      sinqia_body[:nrAgen] = body[:nrAgen]
      sinqia_body[:vlLanc] = body[:value]

      # if Time.now.utc.hour > 20
      #   date = DateTime.now.next_day
      # else
      if date.nil?
        date = DateTime.now
      end

      if date.hour > 20
        date = DateTime.now.next_day
      end


      if date.wday == 6
        date = date.next_day.next_day
      elsif date.wday == 0
        date = date.next_day
      end

      sinqia_body[:dtLanc] = date.strftime("%Y%m%d")
      sinqia_body[:tpTransf] = is_ted ? 2 : 3
      sinqia_body[:tpCtaFav] = 'CC'
      sinqia_body[:nrSeqDes] = 0
      sinqia_body[:cdOrigem] = 24556
      sinqia_body[:nrDocCre] = 9
      sinqia_body[:cdFin] = 30
      sinqia_body[:nrSeq] = 0
      sinqia_body[:dsHist] = ''
      sinqia_body[:dsHistC] = ''
      sinqia_body[:nrBcoDes] = body[:beneficiary][:bankId]
      sinqia_body[:nrCpfCnpj] = body[:beneficiary][:docIdCpfCnpjEinSSN]
      sinqia_body[:nrAgeDes] = body[:beneficiary][:agency]
      sinqia_body[:nrCtaDes] = body[:beneficiary][:account]

      #adicionando DV
      if !body[:beneficiary][:accountDigit].nil?
        sinqia_body[:nrCtaDes] = "#{sinqia_body[:nrCtaDes]}#{body[:beneficiary][:accountDigit]}".to_i
      end


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


    def getBankTransfers(params)
      params[:nrSeq] = 0
      params[:nrInst] = getInstitution
      params[:nrPrazo] = 120
      params[:tpComprovante] = 1
      response = @request.post(@url + RECEIPTS_PATH, params)
      SinqiaModel.new(response)
    end

    def findReceipt(params)
      params[:nrSeq] = 0
      params[:nrInst] = getInstitution
      response = @request.post(@url + FIND_RECEIPTS_PATH, params)
      SinqiaModel.new(response)
    end

  end
end
