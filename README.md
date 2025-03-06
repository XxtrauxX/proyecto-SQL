# Parques Naturales

Administración de Parques Naturales

## Comenzando 🚀

El siguiente proyecto de SQL tiene como fin la administración eficiente de información por medio de Bases de Datos relacionales.


## Descripción del Problema

El objetivo del proyecto es diseñar y desarrollar una base de datos que permita gestionar de manera eficiente todas las operaciones relacionadas con los parques naturales bajo la supervisión del Ministerio del Medio Ambiente. El sistema abarcará la administración de departamentos, parques, áreas, especies, personal, proyectos de investigación, visitantes y alojamientos, asegurando una solución robusta, optimizada y capaz de facilitar consultas críticas para la toma de decisiones.




### Pre-requisitos 📋

Para Ejecutar el siguiente proyecto se utilizara el siguiente Software de base de datos #DBeaver

## Descargar en Windows 
```
choco install dbeaver -y
```

## Descargar En macOS (usando Homebrew)
```
brew install --cask dbeaver-community
```

## Descargar En Linux (Debian/Ubuntu)
```
wget -O dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo apt install ./dbeaver.deb
```

## Despliegue 📦

### Prueba de Conexión


Abra una terminal y Escriba:

```
mysql -u root -p
```
Ingresa la contraseña que configuraste. Si ve el mensaje mysql> , MySQL está funcionando correctamente.

## Reporte  General del Proyecto ⚙️

El primer paso es crear el diagrama de la base de datos, con el Software draw.io  que sienta las bases de la arquitectura física del proyecto, despues se procede a hacer la crecion del Script con el Administrador de Base de Datos DBeaver, se crea la base de datos, se crean las tablas con las diferentes caracteristicas, llaves primarias, llaves foraneas y demás, seguido se procede a la inserción de datos segun los requerimentos del PROYECTO, después se crea la sección CONSULTAS, con consultas Avanzadas y Básicas, que ayudan a agrupar la informacion suministrada de una mejor manera, seguido se crea la sección PROCEDIMIENTOS ALMACENADOS donde mas adelante se explica sus funcionalidas e incorporación al PROYECTO, creación sección FUNCIONES donde se detalla su funcionamiento y finalidad, también se crea la sección Triggers donde se especifica su uso y funcionamineto en el PROYECTO, también se crea sección de EVENTOS donde de manera practica se especifica su utilidad y motivo de incorporación, como información adicional en este documento se especifica en la sección USUARIOS Y PERMISOS los roles, permisos y demás privilegios de los distintos USURIOS creados, También se especifica los contribuyentes a este PROYECTO, la LICENCIA y datos adicionales

## Creación de Tablas

### Estructura y Creación de la Base de Datos (Detallado)

Segun la informacion propuesta creamos las primeras tablas, sin tener encuenta aún las relaciones.

segun la informacion que tenemos, son 8 primeras entidades(TABLAS)
1. Departamento
2. Parque
3. Area(Parque)
4. Especies
5. Personal
6. proyecto investigación
7. visitante
8. Alojamiento


son las primeras TABLAS que obtuvimos

## Normalizar 

Una vez tenemos definidas las primeras tablas, Se procede a Crear nuevas tablas, tablas de transición para que la realación entre TABLAS no sea de Muchos a Muchos, y la estructura relacional pueda funcionar de la manera correcta

### Imagen primeros avances

![Imagen Primeros Avances](https://github.com/XxtrauxX/proyecto-SQL/blob/main/Modelo%20de%20Datos/boceto1-P%C3%A1gina-1.jpg)



## Consultas
breve explicacion sobre las consultas utilizadas en este proyecto

Proporcionar ejemplos de algunas consultas SQL (básicas y avanzadas) que se pueden ejecutar en la base de datos, explicando qué información generan.


## Procedimientos Almacenados

Explicar brevemente la funcionalidad de los procedimientos almacenados, funciones, triggers y eventos creados. Incluir ejemplos de cómo se pueden usar en el contexto del sistema.


## funciones

Procedimientos, Funciones, Triggers y Eventos: Explicar brevemente la funcionalidad de los procedimientos almacenados, funciones, triggers y eventos creados. Incluir ejemplos de cómo se pueden usar en el contexto del sistema.


# Triggers

Procedimientos, Funciones, Triggers y Eventos: Explicar brevemente la funcionalidad de los procedimientos almacenados, funciones, triggers y eventos creados. Incluir ejemplos de cómo se pueden usar en el contexto del sistema.


## Eventos

Procedimientos, Funciones, Triggers y Eventos: Explicar brevemente la funcionalidad de los procedimientos almacenados, funciones, triggers y eventos creados. Incluir ejemplos de cómo se pueden usar en el contexto del sistema.



## Usuarios y Permisos

Describir los 5 roles de usuario creados en el sistema, junto con los permisos asignados a cada uno. Incluir instrucciones sobre cómo crear usuarios en MySQL y cómo asignarles los roles correspondientes.



## Construido con 🛠️

* [DBeaver](https://dbeaver.io/) - Software de Administración de BASES DE DATOS
* [Visual Studio Code](https://code.visualstudio.com/) - Para organizar el esquema del proyecto subir los commits a GitHub y gestionar oportunamente el README.


## Contribuyendo 🖇️

Por favor lee el [CONTRIBUTING.md](https://gist.github.com/villanuevand/xxxxxx) para detalles de nuestro código de conducta, y el proceso para enviarnos pull requests.

## Wiki 📖

Puedes encontrar mucho más de cómo utilizar este proyecto en nuestra [GitHub](https://docs.github.com/es/repositories/working-with-files/using-files/downloading-source-code-archives)


## Autores ✒️

Este proyecto fue individual sin colaboradores externos

* **Oscar Alejandro Díaz Ojeda** - *Creación del PROYECTO* - [XxtrauxX](https://github.com/XxtrauxX/proyecto-SQL/)


También puedes mirar la lista de todos los [contribuyentes](https://github.com/your/project/contributors) quíenes han participado en este proyecto. 

## Licencia 📄

Este proyecto está bajo la Licencia (Tu Licencia) - mira el archivo [LICENSE.md](LICENSE.md) para detalles

Licencia y Contacto: Incluir una sección sobre la licencia del proyecto (opcional) y cómo contactarte en caso de preguntas o problemas con la implementación.


---
⌨️ con ❤️ por [Oscar Díaz](https://github.com/XxtrauxX) 😊