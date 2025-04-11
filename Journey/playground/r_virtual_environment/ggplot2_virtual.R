if (!file.exists("renv.lock")) {
  library(renv)
  renv::init()
}

library(ggplot2)
print("El entorno renv está funcionando en Visual Studio")
