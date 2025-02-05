# port visits
# vamos continuar com o exemplo que tinhamos antes

id_test2
"2ca1c3012-2271-15cd-ea08-2e536333f615"

visitas_porto <- get_event(event_type = "PORT_VISIT",
          vessels = "2ca1c3012-2271-15cd-ea08-2e536333f615",
          start_date = "2017-01-26",
          end_date = "2022-12-31",
          key = gfw_auth())
names(visitas_porto)

View(visitas_porto)
visitas_porto %>% tidyr::unnest_wider(event_info) %>% View()

# da para filtrar só pela confidence
get_event(event_type = "PORT_VISIT",
          vessels = "2ca1c3012-2271-15cd-ea08-2e536333f615",
          start_date = "2017-01-26",
          end_date = "2022-12-31",
          confidence = c(4), # only for port visits
          key = gfw_auth())


get_event(event_type = "PORT_VISIT",
          vessels = c("2ca1c3012-2271-15cd-ea08-2e536333f615"),
          start_date = "2017-01-26",
          end_date = "2022-12-31",
          confidence = c(3), # only for port visits
          key = gfw_auth())


# GAPS - interrupcoes na transmissao

gaps <- get_event(event_type = "GAP",
          vessels = c("e0c9823749264a129d6b47a7aabce377",
                      "8c7304226-6c71-edbe-0b63-c246734b3c01"),
          start_date = "2017-01-26",
          end_date = "2023-02-04",
          key = gfw_auth())
View(gaps)
gaps %>% unnest_wider(event_info) %>% View() #para ver a informacao de cada evento

# da para filtrar por gaps intencionais
get_event(event_type = "GAP",
          vessels = c("e0c9823749264a129d6b47a7aabce377",
                      "8c7304226-6c71-edbe-0b63-c246734b3c01"),
          start_date = "2017-01-26",
          end_date = "2023-02-04",
          gap_intentional_disabling = TRUE,
          key = gfw_auth()) %>%
  unnest_wider(event_info)


