source("https://inkaverse.com/setup.r")

# Cargar datos

url <- "https://docs.google.com/spreadsheets/d/1Ea2VrwmtL6z8P4OXNFdt8pYaBztUMnprRzJmUIJmd_s/edit?usp=sharing"

gs <- as_sheets_id(url)
fb <- range_read(gs, sheet = "fb")

View(fb)

# Hacer etiquetas

library(huito)

font <- c("Permanent Marker", "Tillana", "Courgette")

huito_fonts(font)

label <- fb %>% 
  mutate(color = case_when(
    concentraciones %in% "agua" ~ "blue"
    , concentraciones %in% "15" ~ "darkgreen"
    , concentraciones %in% "25" ~ "#f0c17f"
    , concentraciones %in% "35" ~ "#e0b046"
    , concentraciones %in% "glifosato" ~ "#ff5aa4"
  )) %>% 
  label_layout(size = c(5, 2.5)
               , border_color = "blue"
  ) %>%
  include_barcode(
    value = "qrcode"
    , size = c(2.5, 2.5)
    , position = c(1.25, 1.25)
  ) %>%
  include_text(value = "concentraciones"
               , position = c(2.5, 1.5)
               , size = 6
               , color = "color" 
               , font = font[2]
               , opts = list(hjust = 0.0, vjust = 0.0)
               ,prefix = "concentraciones: "
  ) %>%
  include_text(value = "variedades"
               , position = c(2.5, 1)
               , size = 7
               , color = "#009966"
               , font = font[3]
               , opts = list(hjust = 0.0, vjust = 0.0)
               , prefix = "variedades: "
  ) %>% 
  include_text(value = "plots"
               , position = c(4.5, 0.5)
               , angle = 0
               , size = 5
               , color = "red"
               , font = font[1]
               , prefix = "Plot: "
  )

#ver imagen individual
label %>% 
  label_print(mode = "preview")

#exportar en pdf
label %>% 
  label_print(mode = "complete", filename = "etiquetas", nlabels = 70)
