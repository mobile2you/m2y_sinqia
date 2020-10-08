require "m2y_sinqia"



a = M2ySinqia::SinqiaAccount.new("F4190B60-CB07-07C6-7739-2EF70E1B01B7", "B35E1B8F-2C00-BD24-036A-EEBADDBE95AF", "prod")



# cdt_params = {:name=>"dsdsadasdsa", :type=>"PF", :birthDate=>"2006-05-04", :document=>"03631221843", :email=>"caiolopes@gmail.com", :motherName=>"cadsadas", :fatherName=>nil, :idNationality=>1, :idProfession=>"2", :idNumber=>"323232", :issuingDateIdentity=>"2020-05-04", :incomeValue=>22222000.0, :idBusinessSource=>1, :idProduct=>1, :isPep=>false, :dueDate=>10, :phone=>{:idPhoneType=>18, :areaCode=>"011", :number=>"971806013"}, :address=>{:street=>"Alameda Ministro Rocha Azevedo", :number=>11, :complement=>"11", :neighborhood=>"Cerqueira Cesar", :city=>"Sao Paulo", :federativeUnit=>"SP", :country=>"Brasil", :idAddressType=>1, :mailingAddress=>true, :zipCode=>"01410000"}, :termsAndConditionsTokens=>nil, :deviceIdentification=>{:fingerprint=>"5eb07e5dfc402b3a556f9d7c"}}



p a.getAccounts("70A44589-B636-5452-14F3-E53604341E34")
