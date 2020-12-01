module M2ySinqia

  class SinqiaModule

    def startModule(access_key, secret_key, env)
      @request = SinqiaRequest.new(access_key, secret_key)
      @url =
      if SinqiaHelper.homologation?(env)
        @url = URL_HML
      elsif SinqiaHelper.production?(env)
        @url = URL_PRD
      else
        @url = URL_DEV
      end
    end

    def generateResponse(input)
      SinqiaHelper.generate_general_response(input)
    end

    def getInstitution
      # response = @request.get(@url + USER_PATH)
      # SinqiaModel.new(response).nrInst
      INSTITUTION_ID
    end


    def sinqiaBody(body)
      sinqia_body = {}
      sinqia_body[:cdCta] = body[:cdCta]
      sinqia_body[:nrAgen] = body[:nrAgen]
      sinqia_body[:tpCtaptb] = 'CC'
      sinqia_body[:nrSeqDes] = 0
      sinqia_body[:nrSeq] = 0
      sinqia_body[:nrBanco] = body[:beneficiary][:bankId]
      sinqia_body[:nrCpfcnpj] = body[:beneficiary][:docIdCpfCnpjEinSSN]
      sinqia_body[:nrAgedes] = body[:beneficiary][:agency]
      sinqia_body[:cdCtades] = body[:beneficiary][:account]
      sinqia_body[:nmFav] = body[:beneficiary][:name]
      sinqia_body[:nmApel] = body[:beneficiary][:name]
      sinqia_body[:dsPesq] = body[:beneficiary][:name]
      sinqia_body[:nrInst] = getInstitution
      sinqia_body
    end

    def addFav(body)
      sinqia_body = sinqiaBody(body)
      response = @request.post(@url + ADD_FAV_PATH, sinqia_body)
      puts response
    end

    def checkFav(body)
      sinqia_body = sinqiaBody(body)
      sinqia_body[:tpFiltro] = 1
      response = @request.post(@url + CHECK_FAV_PATH, sinqia_body)
      puts response
      if response["listaFavorecidos"].nil?
        false
      else
        response["listaFavorecidos"].each do |fav|
          if fav["cdCtades"] == sinqia_body[:cdCtades]
            return true
          end
        end
        false
      end
    end

  end

end
