  # Limpiado de vriables
  rm(list = ls())
  
  #install.packages("rvest")
  
  # cargar las librerias
  library(xml2)
  library(rvest)
  source('libreriasYapo.R')

  fullDatos <- data.frame()
  for(numeroPagina in 1:5){
    readHtml <- read_html(paste("https://www.yapo.cl/region_metropolitana?ca=15_s&o=",numeroPagina,sep = ""))
    print(paste("Descargando pagina nro:",numeroPagina))
    nodeTabla <- html_nodes(readHtml, ".listing_thumbs")
    nodeTabla <- html_nodes(nodeTabla, ".title")
    linksProductos <- html_attr(nodeTabla,"href")
    
    for (urlYapo in linksProductos) {
      htmlSeg <- read_html(urlYapo)
      
      print(paste("Descargando URL ==> ",urlYapo))
      
      textoTipoAviso <- obtener(htmlSeg)
      precio <- sacandoPrecio(htmlSeg)
      fullDatos <- rbind(fullDatos,data.frame(categoria = textoTipoAviso, precio = precio))
    }
  }
  
  ggplot(fullDatos,aes(x = categoria))+
    geom_bar()+
    coord_flip()
  
  View(fullDatos)

  
  
  
  
  
  
  




