module M2ySinqia

	class SinqiaService < SinqiaModule

        def initialize(access_key, secret_key, env)
            startModule(access_key, secret_key, env)
	    end


        def p2pTransfer(body)
            #fix cdt_params
            sinqia_body = {}
            sinqia_body[:externalIdentifier] = rand(1..999999)
            sinqia_body[:totalAmount] = body[:amount]
            sinqia_body[:currency] = "BRL"
            sinqia_body[:paymentInfo] = {
                transactionType: "InternalTransfer",
            }
            sinqia_body[:sender] = {
                    account: {
                    	accountId: body[:originalAccount]
                    }
             }

            sinqia_body[:recipients] = [{
                    account: {
                    	accountId: body[:destinationAccount]
                    },
                    amount: body[:amount],
                    currency: "BRL"
             }]

            puts sinqia_body

			int_amount = (body[:amount].divmod 1)[0].to_s


            response = @request.post(@url + PAYMENT_PATH, sinqia_body,[body[:originalAccount], int_amount,body[:destinationAccount], int_amount].join("") )
            p2p = SinqiaModel.new(response)
            # recipient.accountId, and recipient.amount
            if p2p && p2p.data
                p2p.id = p2p.data["transactionId"]
                p2p.idAdjustment = p2p.data["transactionId"]
                p2p.idAdjustmentDestination = p2p.data["transactionId"]
                p2p.transactionCode = p2p.data["transactionId"]
                # p2p.content = p2p
                p2p.statusCode = 200
            end
            p2p
        end


	end
end
