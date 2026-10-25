# Practica 3 : Instalación del Entorno Oracle - Estudiante v1.0

## Docker

### 1. ¿Qué diferencia hay entre una imagen y un contenedor? Usa como ejemplo lo que hiciste en G2 y G4.

La imagen es la plantilla desde la que se crea un contenedor. El contenedor es el entorno concreto que ejecutamos, sirve principalmente para trabajar en entornos colaborativos en los que queremos que todos los miembros del grupo tengan las mimsas versiones de tecnologias, lenguajes y demas. En G2 usamos la imagen 'hello-world' para ejecutar su mensaje. En G4 creamos el contenedor 'prueba' usando 'alpine:3.20' y entramos en él.

### 2. En G5 el archivo nota.txt desapareció y en G6 no. ¿Por qué?

En G5 el archivo estaba guardado dentro del contenedor y se perdió al borrarlo. En G6 usamos el volumen 'datos-prueba'. Como el volumen se conserva aunque borremos el contenedor, pudimos leer el archivo desde otro nuevo.

### 3. ¿Qué diferencia hay entre docker ps y docker ps -a? ¿Qué significa Exited (0)?

'docker ps' muestra los contenedores que están funcionando. Con 'docker ps -a' vemos también los detenidos. 'Exited (0)' significa que terminó bien, mientras que otro código indica un error.

### 4. En -p 8181:8181, ¿qué número corresponde al equipo y cuál al contenedor? ¿Qué pasaría con -p 80:8080 en nginx?

El primer puerto es el de nuestro equipo y el segundo es el del contenedor. Con '-p 80:8080' no funcionaría la página porque nginx escucha en el puerto 80 del contenedor. Por eso usamos '-p 8080:80'.

### 5. ¿Por qué Oracle se queda en marcha y hello-world termina?

Porque depende del proceso principal del contenedor. 'hello-world' termina cuando acaba de mostrar el mensaje. Oracle sigue funcionando porque el motor de la base de datos se mantiene activo.

### 6. ¿Qué es el digest y por qué lo registramos si usamos latest?

El digest identifica exactamente la imagen que hemos descargado. 'latest' puede cambiar y apuntar a una versión más nueva. Guardando el digest sabemos cuál usamos en la práctica.

### 7. ¿Qué comando borraría realmente los datos de Oracle? ¿Por qué docker rm oralab-26ai no lo hace?

El comando sería 'docker volume rm oralab-26ai-data', cuando el volumen ya no esté asociado a ningún contenedor. Borrar el contenedor con 'docker rm oralab-26ai' no borra sus datos porque están guardados en ese volumen.

## Git, organización y evidencia

### 8. ¿Por qué hacemos el laboratorio dentro del repositorio, con Issue, rama y Pull Request?

Para tener organizado el trabajo y poder ver los cambios que hemos hecho. El Issue explica la tarea, la rama permite hacerla sin tocar main y el Pull Request sirve para que un compañero la revise. También dejamos los scripts para poder repetir la instalación.

### 9. ¿Qué diferencia hay entre source 00-config.sh y bash 00-config.sh? ¿Por qué usamos source?

Con 'source' las variables se cargan en la terminal que estamos usando y podemos utilizarlas después. Con 'bash' se ejecutan en otro proceso y no se quedan en nuestra terminal. Por eso cargamos la configuración con 'source'.

### 10. Explica cada parte de 20260915T091230Z_02-docker.script.log.

'20260915' es la fecha, el 15 de septiembre de 2026. La 'T' separa la fecha de la hora. '091230' indica las 09:12:30 y la 'Z' significa que está en UTC. El '02' es el número del paso, 'docker' describe la evidencia y '.script.log' indica que es una salida de terminal.

### 11. ¿Para qué sirve .gitattributes y qué error evita?

Sirve para definir cómo trata Git los archivos. En esta práctica usamos 'eol=lf' para que los archivos de shell, SQL y Markdown tengan finales de línea LF. Así evitamos problemas al pasar scripts entre Windows, macOS y Linux, como los errores relacionados con caracteres de retorno de carro.

### 12. ¿Por qué elegimos Create a merge commit en lugar de Squash and merge?

Porque queremos mantener los commits de cada parte de la práctica. Si hacemos squash se juntan en uno solo y no se ve igual el proceso que hemos seguido.

## Seguridad

### 13. Describe las cuatro capas de protección de contraseñas y qué pasaría si omitimos la primera.

Primero ponemos 'config/.env' en '.gitignore'. Después creamos '.env.example' con valores de ejemplo. Luego hacemos nuestro '.env' con las contraseñas reales y comprobamos que Git lo ignora. Por último cargamos las variables para usarlas en los comandos. Si nos saltamos la primera capa podríamos subir las contraseñas al repositorio sin darnos cuenta.

### 14. ¿Por qué no escribimos la contraseña directamente en docker run?

Porque el comando puede quedarse en el historial de la terminal o en una grabación. Usando la variable 'ORACLE_PWD', en el comando queda el nombre de la variable y no la contraseña escrita.

### 15. Si una contraseña aparece en un commit publicado, ¿basta con borrarla en otro commit?

No, porque se puede seguir viendo en los commits anteriores. Hay que cambiar la contraseña, avisar al profesor y gestionar su retirada del historial. Borrarla en un commit nuevo no hace que deje de estar expuesta.

## Oracle y herramientas

### 16. ¿Por qué no usamos SPOOL ni @archivo.sql con SQL\*Plus dentro del contenedor?

Porque SQL\*Plus se está ejecutando dentro del contenedor y buscaría o guardaría los archivos allí. En su lugar enviamos nuestro archivo SQL con la redirección '<' y guardamos la salida con 'tee'. Con SQLcl sí usamos 'SPOOL' porque está instalado en nuestro Mac.

### 17. ¿Qué hace WHENEVER SQLERROR EXIT SQL.SQLCODE y qué pasaría sin esa línea?

Hace que SQL\*Plus se detenga si una sentencia SQL o un bloque PL/SQL falla y devuelve un código de error. Sin esa línea podría seguir ejecutando el resto aunque hubiera algo mal. Las instrucciones DDL que ya se hayan aplicado no se deshacen automáticamente.

### 18. ¿Qué es una migración y por qué V000 y V001 no deben editarse después de aplicarlas?

Una migración es un archivo con cambios para la base de datos que se aplica siguiendo un orden. V001 crea los usuarios y tablespaces, y V000 crea las tablas e índices. Si las cambiamos después, el archivo ya no representaría lo que hemos ejecutado. Para cambios posteriores se crea otra migración.

### 19. ¿Por qué SQL Developer usa el servicio FREEPDB1 y no FREE ni un SID?

Porque 'FREEPDB1' es la base de trabajo donde hemos creado los esquemas. El servicio 'FREE' conecta con el contenedor raíz. Tenemos que elegir el nombre de servicio 'FREEPDB1' para entrar en el sitio correcto.

### 20. ¿Qué aporta SQLcl frente a SQL\*Plus y por qué debemos dominar ambas?

SQLcl tiene funciones más cómodas para trabajar, como autocompletado, formatos de salida y conexiones guardadas. También se integra con Liquibase. SQL\*Plus es la herramienta clásica y está disponible en muchos servidores Oracle. Por eso viene bien conocer las dos.

## Entorno de trabajo

### 21. ¿Por qué el curso pasa de Git Bash a Ubuntu en WSL 2? Indica dos problemas que desaparecen.

Porque WSL 2 ofrece un entorno Linux real, más parecido al de los servidores. Evita problemas de Git Bash como la conversión de rutas en los comandos de Docker y los fallos con terminales interactivas. También permite instalar herramientas habituales de administración. Yo he utilizado la alternativa para macOS que contempla la práctica.

### 22. ¿Por qué clonamos dentro de Linux y recomendamos bash frente a zsh para los scripts?

En Windows se recomienda guardar el repositorio dentro de Linux para evitar problemas de rendimiento, permisos y finales de línea al trabajar sobre '/mnt/c'. En mi caso, al usar macOS, he trabajado en '/Users/alvaro/Desktop/DEV/oracle-database-lab'.

Se recomienda bash para los scripts porque es habitual en servidores y así evitamos diferencias con zsh. En el Mac puedo seguir usando zsh en la terminal y ejecutar los scripts con 'bash archivo.sh'.
