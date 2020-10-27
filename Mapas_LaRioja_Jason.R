
library(sf)
library(ggplot2)

# https://github.com/iderioja/base_datos_geografica

setwd('C:/Users/raul/Documents/Data Science Proyectos/Mapas En R. La rioja/base_datos_geografica-master/base_datos_geografica-master')

municipios <- st_read("municipios.json")
carreteras <- st_read("carreteras.json")
albergues <- st_read("albergues.json")
poligonos <- st_read("poligonos_industriales.json")

# Es importante tener en cuenta que para que estos ficheros se lean correctamente deben estar situados en nuestro directorio de trabajo.
# Dentro de la carpeta general es recomendable determinar una subcarpeta donde se encuentren los datos.

# VISUALIZACIÓN de los municipios de la Rioja.
ggplot(data = municipios) +
  geom_sf()

# La primera parte ggplot(data = municipios) indica que los datos principales se almacenan en el objeto municipios.
# El + indica que la funcion no esta terminada, El funcionamiento de ggplot2 consiste en concatenar llamadas a funciones hasta crear el mapa que deseemos.
# Por ultimo, usamos la función geom_sf, que sirve para agregar la geometría almacenada en un objeto sf

#### PROYECIONES ####
# Por defecto, el mapa toma el sistema de coordenadas de la primera capa que definimos. 
#Si no hay ningún sistema de referencia de coordenadas definido, utiliza WGS84 (latitud/longitud, el sistema de referencia usado en el GPS).

# MODIFICACIÓN DE PROYECCIÓN

ggplot(data = municipios) +
  geom_sf() +
  coord_sf(crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000
           +y_0=3210000 +ellps=GRS80 +units=m +no_defs ") #notese que el mapa ha girado.

###### COLORES Y BORDES #####

ggplot(data = municipios) +
  geom_sf(fill = "red", color = "black")
# usamos geo_sf para la impresion del mapa, aun sin realizar especificación alguna como en el bloque de codigo anterior, debemos colocarlo
# para poder imprimir el mapa. 


#ggplot(data = municipios) +
# geom_sf(aes(fill = area)) Si tuvieramos un area por territorio mostraria el degradado.

##### TITULO, SUBTITULO, Y ETIQUETA DE LOS EJES #### 

ggplot(data = municipios) +
  geom_sf(fill = "grey", color = "black") + 
  xlab("Longitud") + ylab("Latitud") +
  ggtitle("Mapa de los municipios de La Rioja",
          subtitle = "Realizado por: Raúl Vila")

# Para introducir un título y un subtítulo se emplea la función ggtitle. 
# Mientras que las etiquetas de los ejes x  e y puede añadirse con la funciones xlab e ylab respectivamente.

#### AÑADIR MAS CAPAS AL MAPA ####
# Para agregar mas informacion al mapa, escribir el código en geom_sf(data= AQUI LSO DATOS A SOBREPONER, color = 'red').

ggplot(data = municipios) +
  geom_sf(color='black') +
  xlab("Longitud") + ylab("Latitud") +
  ggtitle("Mapa de los municipios de La Rioja",
          subtitle = "Realizado por: Diana Alonso") +
  geom_sf(data=carreteras, color = 'red') +
  geom_sf(data=albergues, color = 'orange') +
  geom_sf(data=poligonos, color = 'skyblue2')

# Si observamos el mapa podemos ver que el sur tendria una estuctura productiva mas de servicios.
# Mientas que el norte relacionado con el desarrollo industrial. Por la presencia de poligonos. 
  
#### FLECHA DE NORTE Y ESCALA ####

# El paquete ggplot2 no incluye funciones que permitan incorporar barras de escalas o flechas de norte.
# Para ello, debemos acceder a paquetes adicionales como ggspatial
library(ggspatial)
# Utilizando este paquete, las flechas del norte se agregan usando la función annotation_north_arrow(), y las barras de escala se pueden agregar usando annotation_scale().

# Creación de mapa con flecha de norte y barra de escala
ggplot(data = municipios) +
  geom_sf(color='black') +
  xlab("Longitud") + ylab("Latitud") +
  ggtitle("Mapa de los municipios de La Rioja", 
          subtitle = "Realizado por: Raúl Vila") +
  geom_sf(data=carreteras, color = 'red') +
  annotation_scale() +
  annotation_north_arrow(location='tr') #Estas dos lineas fueron las agregadas. 

#el argumento location permite modificar la localización de la flecha o la barra dentro del gráfico. Sus posibles valores son:
#tr (top right) que generará el objeto arriba a la derecha.
#tl (top left) que generará el objeto arriba a la izquierda.
#br (bottom right) que generará el objeto abajo a la derecha.


#### VENTAJAS DE TRABAJAR EN R ####

# R es un software libre, lo que lo hace accesible para todos.
# Tiene grandes comunidades de intercambio de información. 
# Podemos automatizar rápidamente la creación de multitud de mapas.


# Usar software libre nos beneficia como comunidad #






