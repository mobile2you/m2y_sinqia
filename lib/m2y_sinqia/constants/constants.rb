module M2ySinqia
  
  #envs
  HOMOLOGATION = "hml"
  PRODUCTION = "prd"
  DEVELOPMENT = "dev"


  #urls
  URL_DEV = "https://dev.softpartech.com.br"
  URL_HML = "http://191.232.247.11:8090"
  URL_PRD = "http://191.232.247.11:8090"

  #banks
  BANK_ID_DEV = 1422
  BANK_ID_HML = 1422
  BANK_ID_PROD = 1422

  ### Paths

  #account
  
  DEPOSIT_PATH = "v1/accounts/deposits"
  PAYMENT_PATH = "v1/payments"

  STATEMENT = "/statement"
  WITHDRAW = "/withdraw"

  BANKS_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0102A1/listarBancos"
  ACCOUNT_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0102M/obterContas"
  USER_PATH = "/API/BJ08M01/user"
  INDIVIDUAL_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0101L/buscaDadosCliente"
  CUSTOMERS_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0107A/obterClientes"
  EXTRACT_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0101C/listaLancamentos"
  RECEIPTS_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0101M/obterComprovantes"
  FIND_RECEIPTS_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0101N/criarComprovante"
  TRANSFER_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0101K/efetuaLancamentoTransferencia"
  ADD_FAV_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0102O/manutencaoCadastrarFavorecido"
  CHECK_FAV_PATH = "/API/BJ08M01/BJ08M01/BJ08SS0102O/manutencaoListarFavorecidos"

end
