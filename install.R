install.packages(c('purrr', 'devtools'))
purrr::walk2(.x = c("ggplot2", "beeswarm", "tidyverse", "hexbin", "patchwork", , .y = c("3.3.0", "0.2.3", "1.3.0", "1.28.1", "1.0.0", "1.0.0", "2.3", , ~devtools::install_version(package = .x, version = .y))

install.packages(c('purrr', 'devtools'))
purrr::walk2(.x = "cowplot", "gridExtra", "knitr"), .y = "1.28"), ~devtools::install_version(package = .x, version = .y))

