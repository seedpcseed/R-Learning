install.packages(c('purrr', 'devtools'))
purrr::walk2(.x = c("ggplot2", "beeswarm", "tidyverse", "reshape", "reshape2", "cowplot", "tidyr", "hexbin", "patchwork", "gridExtra", "knitr"), .y = c("3.3.0", "0.2.3", "1.3.0", "0.8.8", "1.4.4", "1.0.0", "1.0.3", "1.28.1", "1.0.0", "2.3", "1.28"), .f= ~devtools::install_version(package = .x, version = .y))
devtools::install_github(c("dcl-docs/dcldata@0e1ea926828101ba99ce1b926cf228f9d4087cf3"))

