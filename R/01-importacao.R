library(tidyverse)

# cria as pastas data-raw e data (pq no github elas estao no gitignore por serem os lugares em que os arquivos pesados ficam)
if(!dir.exists("data-raw")) dir.create("data-raw")
if(!dir.exists("data")) dir.create("data")

unzip("data-raw/MEC_1_2_3_Simplificado.zip", exdir = "data-raw")
mec_simplificado <- data.table::fread("data-raw/MEC_1_2_3_Simplificado.csv") %>% as_tibble(.name_repair = "unique")
write_rds(mec_simplificado, path = "data/mec_simplificado.rds")
