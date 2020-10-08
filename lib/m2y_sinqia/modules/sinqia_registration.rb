
module M2ySinqia

	class SinqiaRegistration < SinqiaModule

        def initialize(access_key, secret_key, env)
            startModule(access_key, secret_key, env)
        end

        def createRegistration(body, version = 1)
            #fix cdt_params
            sinqia_body = {}
            sinqia_body[:externalIdentifier] = rand(1..9999)
            sinqia_body[:sharedAccount] = false
            sinqia_body[:client] = {
                name: body[:name],
                email: body[:email],
                socialName: body[:legalName].nil? ? body[:name] : body[:legalName],
                taxIdentifier: {
                    country: "BRA",
                    taxId: body[:document]
                },
                mobilePhone: {
                    country: "BRA",
                    phoneNumber: body[:phone][:areaCode].to_i.to_s + body[:phone][:number]
                }
            }
            puts sinqia_body

            response = @request.post(@url + ACCOUNT_PATH, sinqia_body,[sinqia_body[:externalIdentifier], sinqia_body[:client][:taxIdentifier][:taxId]].join("") )
            account = SinqiaModel.new(response)
            
            if account && account.data
                account.data["registration_id"] = account.data["account"]["accountId"]
                account.data["id"] = sinqia_body[:externalIdentifier]
                account.data["account_id"] = sinqia_body[:externalIdentifier]
                account.data["person_id"] = account.data["accountHolderId"]
            end
            account
        end


	end

end
