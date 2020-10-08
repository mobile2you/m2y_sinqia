module M2ySinqia

  class SinqiaModule

      def startModule(access_key, secret_key, env)
        @request = SinqiaRequest.new(access_key, secret_key)
        @url = SinqiaHelper.homologation?(env) ? URL_HML : URL_PRD
      end

      def generateResponse(input)
        SinqiaHelper.generate_general_response(input)
      end
  end

end
