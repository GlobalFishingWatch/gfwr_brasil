# https://docs.google.com/document/d/1AyJEjwIH8ZUmUtheRpKmy0OMIWf8F_o3/edit

# todo o setup deste workspace (você pode copiar e seguir estas instruções localmente)

## Conta na Global Fishing Watch
### Crie uma conta em Global Fishing Watch e gere um token de acesso às APIs
install.packages("usethis")

# Abra e edite o arquivo .R_environ para incluir o token assim:
usethis::edit_r_environ()

# O arquivo .R_environ vai abrir automaticamente, copie e cole seu token assim:
#GFW_TOKEN = "eyJhb..."
# Salve e feche o arquivo e reinicie a sessão de R (menu: Session/Restart R)

# Instalar pacote desde GitHub
# install.packages("remotes")

# chama uma funcao do pacote com ::
 remotes::install_github("GlobalFishingWatch/gfwr",
                         dependencies = TRUE,
                         build_vignettes = TRUE)
