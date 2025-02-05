# R a linguagem e o programa vs RStudio o IDE - a interface de usuario. Tem outras maneiras de rodar R! RStudio é apenas uma, mas é uma das mais eficientes

# quatro paineis

# 1. scripts, arquivos de texto com extensao .R

# control + enter para mandar pro terminal abaixo
# Se > quer dizer o terminal esta pronto
# Se + quer dizer que ficou esperando pro ex. fechar algum parentese
2 + 2
# 2. o terminal de R (Console)
# um terminal do computador

# 3. e 4. Com abas que dá para reorganizar (Tools > )Global Options > Pane Layout
# Environment"Objetos guardados na memória
# vc guarda objetos na memória com o comando <-
# ex.

numero <- 3
# deve aparecer numero e o valor 3 na aba environment.

# Historia

# pacotes - CRAN install.packages("xxx")

# Files
# Um navegador de arquivos

# Plots
# onde vai aparecer os plots

# Help onde fica o help das funcoes e pacotes
# o help vc chama com ? ou help()
# Carrega os pacotes
library(gfwr)

# o help
help("get_vessel_info")

# DEVE APARECER NA ABA HELP
# sempre na mesma estrutura
# Descricao
# Uso (os parametros, a ordem, e quais sao os valores predeterminados/default)
# Argumentos uma explicacao do significado e algumas informacoes
# Detalhes quando for necessário
# Exemplos
# da para rodar marcando ew executando ctrl enter
# ou copia e cola

# Lembre que quando criar objetos é necessario dar um nome e usar <-

# eu estarei explicando os argumentos e o uso das funcoes sempre baseada no help.


# Objetos em R

# Classes
#numeros, caracteres, logico
3
"a"
TRUE

class(3)
class("a")
class("3")
class(TRUE)

# tem outros como o integer:
3L
class(3L) #numeros inteiros, nao vamos usar



# vetores sao criados concatenando com a funcao c()
3

c(3, 2, 1)
objeto <- c(3, 2, 1)
class(objeto)
is(objeto)

# Se misturar caracteres, numerico e logico, o caracter vai ter predominancia sobre o numero e o logico
mix <- c(3, "a")
class(mix)

mix <- c(3, "a", TRUE) #se criar um objeto com o mesmo nome, vai apagar o anterior
mix
class(mix)

# numerico vai ter predominancia sobre logico, TRUE = 1 FALSE = 0
mix <- c(TRUE, 1)
mix
class(mix)


mix <- c(FALSE, 1)
mix
class(mix)

# Isto é importante porque os parametros das funcoes vao dizer que tipo de input
# é esperado
# Se a funcao fala Logical espera-se um TRUE ou FALSE
# Se a funcao fala Numeric espera-se um numero. Isto é 3 e nao "3"


#  Vetores com c()
# Dataframes (tabelas) de varias maneiras. Vc pode criar uma tabela lendo um
# arquivo de excel, por exemplo
dataframe1 <- data.frame(variavel1 = "a",
                         variavel2 = "b",
                         variavel3 = "c")
dataframe1
View(dataframe1)

dataframe2 <- data.frame(variavel1 = c(1, 3, 4),
                        variavel2 = c("b", "oi", 4),
                        variavel3 = c(TRUE, TRUE, FALSE))
dataframe2
# nao precisa ser do mesmo tipo, cada coluna é um vetor.
