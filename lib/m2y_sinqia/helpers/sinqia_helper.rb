require 'json'

module M2ySinqia
  class SinqiaHelper

    def self.homologation?(env)
      env == HOMOLOGATION
    end

    def self.production?(env)
      env == PRODUCTION
    end

    def self.conductorBodyToString(json)
      string = "?"
      arr = []
      json.keys.each do |key|
        if !json[key].nil?
          arr << key.to_s + "=" + json[key].to_s
        end
      end
      string + arr.join("&")
    end

    def self.generate_general_response(input)
      cdtErrorHandler = SinqiaErrorHandler.new
      response = {}
      if cdtErrorHandler.mapErrorType(input)
        response = {
          success: false,
          error: cdtErrorHandler
        }
      else
        response = {
          success: true,
          content: input
        }
      end
      response
    end
  end
end
