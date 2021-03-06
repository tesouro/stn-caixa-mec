library(tidymodels)
library(tidyverse)

# system("gcloud auth login")
#pins::board_register_gcloud(bucket = "ministerio_da_justica")

#modelo <- pins::pin_get("modelo_xgboost", board = "gcloud")
modelo <- readRDS("data/modelo.rds")

ts_das_disponibilidades_liquidas_com_indicadores <- read_rds("data/ts_das_disponibilidades_liquidas_com_indicadores.rds")

# base com scores
ts_das_disponibilidades_liquidas_com_indicadores_final <- ts_das_disponibilidades_liquidas_com_indicadores %>%
  mutate(
    n = map_dbl(serie_temporal, nrow),
    indicadores = map(serie_temporal_random_crop, calcular_indices)
  ) %>% 
  select(id, NO_UG, NO_ORGAO, NO_FONTE_RECURSO, serie_temporal, serie_temporal_random_crop, indicadores) %>%
  unnest(indicadores) %>%
  mutate(
    suspeita_de_empocamento = predict(modelo, ., type = "prob")$.pred_Empoçamento
  )

write_rds(ts_das_disponibilidades_liquidas_com_indicadores_final, "data/ts_das_disponibilidades_liquidas_com_indicadores_final.rds")
write_rds(ts_das_disponibilidades_liquidas_com_indicadores_final, "apps/explorador_disponibilidade_liquidas_v3/ts_das_disponibilidades_liquidas_com_indicadores_final.rds")

shiny::runApp("apps/explorador_disponibilidade_liquidas_v3/")
