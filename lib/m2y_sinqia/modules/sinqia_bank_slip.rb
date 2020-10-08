module M2ySinqia

	class SinqiaBankSlip < SinqiaModule

        def initialize(access_key, secret_key, env)
            startModule(access_key, secret_key, env)
	     end

		def getPDF(id)
            response = @request.get(@url + DEPOSIT_PATH + "/#{id}", ["get:/v1/accounts/deposits/",id].join("") )
            invoice = SinqiaModel.new(response)
            invoice
      		req = HTTParty.get(invoice.data["boleto"]["url"])
      		req.parsed_response
		end


	end
end
