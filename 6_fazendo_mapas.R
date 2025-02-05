# o que é mais legal de fazer com esses dados é mapas.
# a gente tem um artigo com exemplos

# https://globalfishingwatch.github.io/gfwr/articles/making-maps.html

# Carrega pacotes
library(dplyr)
library(tidyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(glue)
library(ggplot2)

# Cria um tema de cores para os mapas

# Map theme with dark background
map_theme <- ggplot2::theme_minimal() +
  ggplot2::theme(
    panel.border = element_blank(),
    legend.position = "bottom", legend.box = "vertical",
    legend.key.height = unit(3, "mm"),
    legend.key.width = unit(20, "mm"),
    legend.text = element_text(color = "#848b9b", size = 8),
    legend.title = element_text(face = "bold", color = "#363c4c", size = 8, hjust = 0.5),
    plot.title = element_text(face = "bold", color = "#363c4c", size = 10),
    plot.subtitle = element_text(color = "#363c4c", size = 10),
    axis.title = element_blank(),
    axis.text = element_text(color = "#848b9b", size = 6)
  )

# Paleta para as cores de atividade
map_effort_light <- c("#ffffff", "#eeff00", "#3b9088","#0c276c")


start_date <- '2021-01-01'
end_date <- '2021-04-01'

# Nossa EEZ é 8464
get_region_id(region_name = "Brazil", region_source = "EEZ")


# Download de datos da EEZ brasileira

eez_fish_df <- get_raster(
  spatial_resolution = "HIGH",
  temporal_resolution = "YEARLY",
  start_date = start_date,
  end_date = end_date,
  region = 8464,
  region_source = "EEZ"
)
# nao estamos agrupando por nenhuma variavel

eez_fish_df

eez_fish_df %>%
  filter(`Apparent Fishing Hours` > 0) %>%
  ggplot() +
  geom_tile(aes(x = Lon,
                  y = Lat,
                  fill = `Apparent Fishing Hours`)) +
  geom_sf(data = ne_countries(returnclass = "sf", scale = "medium")) +
  coord_sf(xlim = c(-55, -40),
           ylim = c(-35, -20)) +
  scale_fill_gradientn(
    trans = 'log10',
    colors = map_effort_light,
    na.value = NA,
    labels = scales::comma) +
  labs(title = "Esforço de pesca aparente na EEZ do Brasil",
       subtitle = glue("{start_date} to {end_date}"),
       fill = "Fishing hours") +
  map_theme


# se a gente tiver tempo :)
# um exemplo em outra regiao, com um shapefile próprio
# se você tiver um shapefile de interesse, basta ler desde o HD com a funcao
# sf::read_sf e usar
meu_shape <- sf::read_sf("data/")
#region_source = 'USER_SHAPEFILE',
#region = meu_shape

meu_shape <- sf::read_sf("data/HC_Galapagos_HighSeas.shp")

fishing_effort <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'DAILY',
                             start_date = '2023-01-01',
                             end_date = '2024-01-01',
                             group_by = "VESSEL_ID",
                             region_source = 'USER_SHAPEFILE',
                             region = meu_shape)

# O que acontece se seu pedido devolve erro 524?
# usar
# fishing_effort <- get_last_report()


fishing_effort %>%
  filter(`Apparent Fishing Hours` > 0) %>%
  ggplot() +
  geom_tile(aes(x = Lon,
                y = Lat,
                fill = `Apparent Fishing Hours`)) +
  geom_sf(data = ne_countries(returnclass = "sf", scale = "medium")) +
  coord_sf(xlim = c(min(fishing_effort$Lon),max(fishing_effort$Lon)),
           ylim = c(min(fishing_effort$Lat),max(fishing_effort$Lat))) +
  scale_fill_gradientn(
    trans = 'log10',
    colors = map_effort_light,
    na.value = NA,
    labels = scales::comma) +
  labs(title = "Esforço de pesca aparente na corrente de Humboldt",
       fill = "Fishing hours") +
  map_theme
