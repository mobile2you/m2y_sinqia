module M2ySinqia

	class SinqiaTransfer < SinqiaModule

        def initialize(access_key, secret_key, env)
            startModule(access_key, secret_key, env)
	     end


		def bankTransfers(body)
			
            #fix cdt_params
            sinqia_body = {}
            sinqia_body[:externalIdentifier] = rand(1..9999)
            sinqia_body[:currency] = "BRL"
            sinqia_body[:totalAmount] = body[:value]
            sinqia_body[:withdrawInfo] = {
                withdrawType: "BankTransfer",
                bankTransfer: {
                    bankDestination: body[:beneficiary][:bankId],
                    branchDestination: body[:beneficiary][:agency],
                    accountDestination: [body[:beneficiary][:account], body[:beneficiary][:accountDigit]].join(""),
                	taxIdentifier: {
                    	country: "BRA",
                    	taxId: body[:beneficiary][:docIdCpfCnpjEinSSN]
                	},
		            personType: "PERSON",
        		    name: body[:beneficiary][:name],
            	    accountTypeDestination: "1"
	            }
            }
            puts sinqia_body

			id = body[:idOriginAccount]
			int_amount = (body[:value].divmod 1)[0].to_s
			sinqia_hash = [int_amount, id, body[:beneficiary][:bankId], body[:beneficiary][:agency], body[:beneficiary][:account], body[:beneficiary][:accountDigit]].join("")


			response = @request.post(@url + ACCOUNT_PATH + id.to_s + WITHDRAW, sinqia_body, sinqia_hash)
			transferResponse = SinqiaModel.new(response)
			
            if transferResponse && transferResponse.data
                transferResponse.id = transferResponse.data["transactionId"]
                transferResponse.statusCode = 200
                transferResponse.transactionCode = transferResponse.data["transactionId"]
                # transferResponse.content = transferResponse
            end
            transferResponse
		end


	end
end
