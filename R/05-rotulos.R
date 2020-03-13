library(tidyverse)

shiny::runApp("apps/app_para_rotular_as_series_temporais_das_disponibilidades_liquidas")

# rotulos -------------
rotulos <- read_csv("data/anotacoes-2020-03-08.csv") %>%
  rename(rotulo = athos) %>%
  select(id, rotulo) %>%
  filter(!rotulo %in% c("Rever dados")) %>%
  mutate(
    rotulo = case_when(
      rotulo %in% "Saudável" ~ "Saudável",
      TRUE ~ "Empoçamento"
    )
  )

write_rds(rotulos, "data/rotulos.rds")
