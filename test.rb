require "m2y_sinqia"


cpf = "98757746375"

a = M2ySinqia::SinqiaBank.new("ws.mobile2you", "z1x2c3v$B%N&", "hml")
p a.getBanks

a = M2ySinqia::SinqiaIndividual.new("ws.mobile2you", "z1x2c3v$B%N&", "hml")
account = a.findPerson(cpf)
puts account

a = M2ySinqia::SinqiaAccount.new("ws.mobile2you", "z1x2c3v$B%N&", "hml")
nrClient = account.nrClient
account = a.getAccounts(account.nrClient)
p account

cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen}

p cdt_params

p a.findAccount(cdt_params)

cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen, dtIni: 20190101, dtFin: 20201012}

p a.getTransactions(cdt_params)


cdt_params = {:cdCta=> account.cdCta, :nrAgen=> account.nrAgen, nrCliente: nrClient}

a = M2ySinqia::SinqiaTransfer.new("ws.mobile2you", "z1x2c3v$B%N&", "hml")
p a.getBankTransfers(cdt_params)

