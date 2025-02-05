library(gfwr)
library(tidyr)
library(dplyr)

# Começamos com o help da funcao
# Uma busca simples
# primeiro parametro é query

info_vessel <- get_vessel_info(query = 431782000, #length 1 quer dizer um so
                               search_type = "search",
                               key = gfw_auth())

# search_type = "search" e key = gfw_auth() sao os defaults
# essa busca é equivalente a get_vessel_info(431782000)

# 2 vessels! como assim.


# exploremos o objeto
# nomes
names(info_vessel) # sete partes (slots) com informacao
# acessar com $ cifrao
info_vessel$dataset

# ou com colchete []
info_vessel["dataset"]

#melhor com $ porque autocompleta

# Explorando o output:
# 1 Informacao de AIS em selfReportedInfo:

info_vessel$selfReportedInfo
info_vessel$selfReportedInfo$ssvid
info_vessel$selfReportedInfo$imo
names(info_vessel$selfReportedInfo)
View(info_vessel$selfReportedInfo)

# o mmsi - ssvid
info_vessel$selfReportedInfo$ssvid
# retorna o que foi pedido 431782000 e mais outros.

# ver o index para entender como vesselid se agrupam juntos
info_vessel$selfReportedInfo[, c("index", "vesselId")]
# pelo index sao dois barcos, os tres primeiros e o quarto

# View do objeto o que dá para ver:
# diferente vesselId para cada segmento por datas
# o primeiro barco tem tudo o mesmo IMO
# nem todos tem o mesmo numero de posicoes
# ...

# Informacao dos registros em registryInfo
info_vessel$registryInfo #os dois barcos

View(info_vessel$registryInfo)

# tem informacao complementar! IMO do segundo que nao estava no AIS, callsign
# tambem geartyper, tonnage, tipo de pesca Longline ou apenas "fishing"
# quer dizer que o algoritmo de GFW ainda nao consegui classificar esse barco além
# dessa categoria.


# Autorizacoes
info_vessel$registryPublicAuthorizations
info_vessel$registryPublicAuthorizations %>% unnest(sourceCode)
#quando vcs encontrem a informacao oculta usem essa funcao unnest do pacote tidyr
# olha como o index aqui é importante só temos autorizacoes pro primeiro barco


# Outros slots
names(info_vessel)
info_vessel$dataset
info_vessel$registryInfoTotalRecords
info_vessel$registryInfo

# quem é dono do barco?
info_vessel$registryOwners
info_vessel$registryOwners %>% unnest(sourceCode)

View(info_vessel$combinedSourcesInfo)
View(info_vessel$registryInfo)


# Da para inferir qualquer comportamento suspeito?
# mmsi pode ser reutilizado, essa é uma das desvantagens
# toda mudanca de bandeira precisa de mudanca no MMSI/ssvid!
# podemos explorar as datas que o mmsi foi utilizado em cada barco:
info_vessel$selfReportedInfo[c("transmissionDateFrom", "transmissionDateTo", "ssvid", "index", "flag")]
#vamos organizar por datas
info_vessel$selfReportedInfo[c("transmissionDateFrom", "transmissionDateTo", "ssvid", "index")] %>%
  arrange(transmissionDateFrom, transmissionDateTo)
# o mmsi que a gente buscou nao foi utilizado ao mesmo tempo! pode ser um caso simples de
# reuso / reciclagem de mmsi

# tem outros argumentos na funcao

info_vessel$selfReportedInfo$vesselId[4] #seleciona o quarto elemento da coluna vesselId


id_test <- info_vessel$selfReportedInfo$vesselId[4] #seleciona o quarto elemento da coluna vesselId
id_test
get_vessel_info(search_type = "id", ids = id_test) #aí só volta a unica id associada

id_test2 <- info_vessel$selfReportedInfo$vesselId[1] #seleciona o quarto elemento da
id_test2
get_vessel_info(search_type = "id", ids = id_test2) #aí só volta a unica id associada mas Ai combined sources info vai mostrar as demais vesselId associadas.

info_vessel$registryOwners
info_vessel$selfReportedInfo
