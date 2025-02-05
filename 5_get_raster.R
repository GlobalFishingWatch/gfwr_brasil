library(gfwr)
library(tmap)

## Fishing effort/esforco de pesca ----

# a gente pode fazer buscas para areas pre definidas (EEZ, areas marinhas protegidas MPA e RFMOs/Orops)

# vamos comecar pela EEZ brasileira
?get_raster()
# region_source = "EEZ
# region = um código!

# a gente busca o código pelo get_region_id()
get_region_id(region_name = "Brazil",
              region_source = "EEZ")
# O código é 8464

#get_region_id(region_name = "Brazil",
#              region_source = "EEZ")
#fuzzy matching importante


# entre janeiro e marco de 2023.
brasil_fisheff <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2023-01-01',
                             end_date = '2023-04-01',
                             region = 8464,
                             region_source = 'EEZ',
                             key = gfw_auth())
# 524 timeout
brasil_fisheff
# colunas que voltam?
# coordenadas, time range, vessel ids, apparent fishing hours

# da para modificar a resolucao espacial, LOW = 0.1 grau, HIGH = 0.01 grau
brasil_fisheff <- get_raster(spatial_resolution = 'HIGH',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2023-01-01',
                             end_date = '2023-04-01',
                             region = 8464,
                             region_source = 'EEZ',
                             key = gfw_auth())
brasil_fisheff #volta muito mais informacao



# da para modificar a resolucao temporal
# A coluna time range vai mostrar apenas ano, mes ou dia de ocorrencia
brasil_fisheff <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'DAILY',
                             start_date = '2021-01-01',
                             end_date = '2021-10-01',
                             region = 8464,
                             region_source = 'EEZ',
                             key = gfw_auth())
brasil_fisheff

# tambem tem como agrupar os resultados usando o parametro group_by
# group_by = "VESSEL_ID" "GEARTYPE" and "FLAGANDGEARTYPE" vai devolver diferentes colunas
brasil_fisheff <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2021-01-01',
                             end_date = '2021-10-01',
                             group_by = "VESSEL_ID",
                             region = 8464,
                             region_source = 'EEZ',
                             key = gfw_auth())
View(brasil_fisheff)
# vessel_ID dá muito mais informacao!
table(brasil_fisheff$flag)

# tambem dá para filtrar e selecionar apenas uma parte do que nos interessa
#como flag de pais relevante
ARG_in_BRA <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2021-01-01',
                             end_date = '2021-10-01',
                             group_by = "FLAGANDGEARTYPE",
                             filter_by = "flag IN ('ARG')",
                             region = 8464,
                             region_source = 'EEZ',
                             key = gfw_auth())
ARG_in_BRA
table(ARG_in_BRA$Geartype)

# dá para filtrar localmente
library(dplyr)
brasil_fisheff %>% filter(Flag == "ARG")



# tem outras opcoes para obter códigos, como areas marinhas protegidas e OROPS/RFMOs
get_region_id(region_name = "Abrolhos", region_source = "MPA")



# também dá para carregar uma área de interesse
# um shapefile -> .shp
# em R, o pacote que lê shapefiles é o sf
# primeiro usar um shapefile pré carregado:
?gfwr
data(test_shape)

library(tmap)
tmap_mode("view")
tm_basemap() +
tm_shape(test_shape) +
tm_borders()

test_shape

# é um objeto sf
#sf::read_sf()


fishing_effort <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2021-01-01',
                             end_date = '2021-10-01',
                             group_by = "FLAG",
                             region_source = 'USER_SHAPEFILE',
                             region = test_shape
                             )

fishing_effort
unique(fishing_effort$flag) # varias bandeiras

