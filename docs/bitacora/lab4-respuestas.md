# Lab 4: Oracle DBA Workflow I — Radiografía de la instancia

## Parte B — Respaldo del estado del Lab 3

### Punto de control: archivos fuera del volumen

Comprobé las rutas y el resultado fue 0 archivos fuera del volumen.

Algunos archivos aparecían en $ORACLE_HOME/dbs, pero al revisar la ruta real comprobé que esa carpeta enlaza con /opt/oracle/oradata/dbconfig/FREE/dbs. Por eso estaban dentro del volumen persistente.

Guardé la copia en:

backups/20261111T173913Z_lab3-final/

Después revisé el contenido y comprobé las sumas SHA-256. Los cuatro archivos dieron OK.

Referencia: 20261111T173912Z_00-backup-lab3.script.log.

### P1 — Copia tras SHUTDOWN IMMEDIATE

**Respuestas: A y D.**

La copia es consistente porque cerré la base con SHUTDOWN IMMEDIATE antes de copiar los archivos. Al restaurarlos todos, la base puede abrirse con STARTUP sin recuperación con redo.

## Parte C — Correcciones del entorno

### Reubicación de los datafiles

Los cinco datafiles de negocio estaban dentro del volumen, pero en una carpeta de configuración. Los reubiqué en:

/opt/oracle/oradata/FREE/FREEPDB1/

Comprobé que los cinco quedaron disponibles, con 100 MB de tamaño, crecimiento automático y un máximo de 1024 MB.

Ejecuté otra vez el guion y confirmó que ya no había archivos que reubicar.

Referencia: 20261111T175544Z_03-reubicar-datafiles.script.log.

### P2 — Reubicar un datafile

**Respuesta: B.**

Primero puse el tablespace en OFFLINE, copié el archivo con el sistema operativo, actualicé su ruta con ALTER TABLESPACE ... RENAME DATAFILE y lo devolví a ONLINE.

RENAME DATAFILE solo cambia la ruta registrada en Oracle; la copia física se hace aparte. Seguí este procedimiento con los cinco datafiles de negocio.

## Parte D — Instancia y base de datos

### P3 — Diferencia entre instancia y base de datos

**Respuestas: A y C.**

Consulté STARTUP_TIME en V$INSTANCE y obtuve 2026-11-14 09:15:00, la fecha y hora de arranque de la instancia.

CREATED, en V$DATABASE, mostró 2026-07-08. Esta fecha corresponde a la creación de la base de datos.

Recrear el contenedor Docker conservando el volumen no crea una base nueva ni cambia su DBID. La base sigue siendo la misma, aunque cambie el contenedor que la ejecuta.

Una instancia tampoco puede montar dos bases de datos a la vez. Las PDB forman parte de la misma CDB.

Además, V$DATABASE se puede consultar en estado MOUNT, aunque la base todavía no esté abierta.

## Parte E — Arranque por etapas y alert log

### Comprobación de las etapas de arranque

En NOMOUNT consulté V$PARAMETER y obtuve los parámetros cargados en memoria. La consulta a V$DATABASE devolvió ORA-01507 porque la base todavía no estaba montada.

En MOUNT consulté los control files y comprobé que Oracle identificaba los 16 datafiles. La consulta a DBA_TABLES devolvió ORA-01219 porque el diccionario todavía no estaba accesible.

Ejecuté ALTER DATABASE OPEN y comprobé que FREE quedó en READ WRITE. FREEPDB1 también se abrió en READ WRITE porque tenía guardado el estado OPEN.

Revisé el alert log y encontré la parada limpia y el arranque posterior. Aparecieron avisos ORA-00800 [Set Priority Failed] de VKTM y LGWR, descritos en el enunciado. La base se abrió correctamente a pesar de esos avisos.

Referencia:

- 20261114T093634Z_06-arranque-por-etapas.script.log
- 20261114T094059Z_06-alert-log.script.log

### P4 — Operaciones en NOMOUNT

**Respuestas: A y C.**

En NOMOUNT están disponibles V$PARAMETER y CREATE CONTROLFILE. La instancia ya está arrancada, aunque la base todavía no está montada.

### P5 — Cambiar a ARCHIVELOG

**Respuesta: B, MOUNT.**

Para ejecutar ALTER DATABASE ARCHIVELOG, la base debe estar montada, pero no abierta.

## Parte F — Configuración y PFILE

### Comparación entre SPFILE y memoria

Comprobé que la instancia había arrancado con un SPFILE.

Exporté la configuración desde el SPFILE y desde memoria. El primer archivo tenía 32 líneas y el segundo, 122.

El segundo contiene también valores que Oracle calcula o toma por defecto, aunque no estén escritos expresamente en el SPFILE.

Guardé los archivos en:

- evidencia/config/initFREE_lab4.ora
- evidencia/config/initFREE_lab4_memoria.ora

### P6 — SCOPE por defecto

**Respuesta: B.**

Si la instancia ha arrancado con SPFILE, ALTER SYSTEM SET utiliza SCOPE=BOTH por defecto. Por tanto, el cambio se aplica en memoria y se guarda para los siguientes arranques.

### P7 — PROCESSES desde una PDB

**Respuesta: C.**

Intenté modificar PROCESSES desde FREEPDB1 y obtuve ORA-65040. Es un parámetro de instancia y debe modificarse desde CDB$ROOT.

### P8 — Recuperación ante un SPFILE incorrecto

**Respuestas: A y C.**

STARTUP PFILE='/ruta/init_bueno.ora' arranca la instancia con una configuración válida.

Después, CREATE SPFILE FROM PFILE='/ruta/init_bueno.ora' permite crear de nuevo el SPFILE para utilizarlo en los siguientes arranques.

## Parte G — Memoria y experimento de caché

### Modelo de gestión de memoria

Comprobé que la instancia utiliza ASMM: MEMORY_TARGET estaba a 0 y SGA_TARGET tenía un valor de 1536M.

La PGA se gestiona por separado, con PGA_AGGREGATE_TARGET = 512M y PGA_AGGREGATE_LIMIT = 2G.

DB_CACHE_SIZE estaba a 0, así que Oracle ajustaba el buffer cache sin un mínimo fijado mediante ese parámetro.

### Interpretación del experimento

La consulta devolvió 17.600 estudiantes activos en las dos rondas.

| Medida           | Caché fría | Caché caliente |
| ---------------- | ---------: | -------------: |
| Lecturas lógicas |        463 |            247 |
| Lecturas físicas |        265 |              0 |

En la segunda ronda obtuve 0 lecturas físicas. La consulta utilizó los bloques que ya estaban en memoria.

Obtuve 463 y 247 lecturas lógicas, a diferencia del ejemplo del PDF. No comprobé la causa de esa diferencia; el resultado que sí observé fue que las lecturas físicas pasaron de 265 a 0.

Al terminar consulté la caché y encontré 245 bloques de ACA_ESTUDIANTES. Las estadísticas de la tabla mostraban 244. El enunciado relaciona esta diferencia con la cabecera del segmento, aunque no comprobé por separado el tipo de cada bloque.

La tasa de acierto de la segunda ronda fue:

1 − físicas/lógicas = 1 − 0/247 = 100 %

Referencia: 20261114T100500Z_08-experimento-cache.script.log.

### P9 — ASMM y DB_CACHE_SIZE

**Respuesta: B.**

Con ASMM, fijar DB_CACHE_SIZE = 512M establece un mínimo para el buffer cache. Oracle puede aumentar su tamaño por encima de ese valor.

### P10 — Estructuras de la PGA

**Respuestas: A y D.**

El área de ordenación y la memoria de sesión de un proceso servidor dedicado forman parte de su PGA.

El shared pool, el log buffer y el buffer cache pertenecen a la SGA.

## Parte H — Procesos de Oracle y Linux

### Comprobación de los procesos

Consulté los procesos desde Oracle y obtuve 87 procesos de fondo y 54 procesos Linux. Los recuentos son distintos porque algunos procesos Oracle se ejecutan como hilos dentro del mismo proceso del sistema operativo.

Encontré cuatro procesos ARCn, algo esperado porque la base estaba en ARCHIVELOG. El ejemplo del PDF estaba en NOARCHIVELOG y por eso mostraba cero.

Busqué LGWR desde Linux y encontré db_lgwr_FREE con el PID 1942.

Abrí una sesión SQLcl en otra pestaña y repetí el guion. Entonces apareció un proceso servidor dedicado:

20767 122 oracleFREE (LOCAL=NO)

LOCAL=NO indica que la conexión llegó por red a través del listener.

Para comparar los identificadores utilicé los PID de dentro del contenedor. docker top muestra los del anfitrión, por lo que sus números pueden ser diferentes.

Tampoco se deben sumar directamente los valores RSS de todos los procesos: parte de la memoria compartida de la SGA aparece contabilizada en varios de ellos.

Referencia: 20261114T143137Z_09-procesos-so.script.log.

### P11 — Escritura necesaria para completar un COMMIT

**Respuesta: C, LGWR.**

El COMMIT espera a que LGWR escriba en los redo logs el redo necesario para confirmar la transacción.

### P12 — Procesos de fondo obligatorios

**Respuestas: B y D, PMON y SMON.**

PMON participa en la limpieza de procesos que han fallado. SMON se encarga de tareas como la recuperación de la instancia al arrancar.

## Preguntas de comprobación — Respaldo

### 1. ¿Por qué la copia es consistente? ¿Qué pasaría con la base abierta?

Primero ejecuté SHUTDOWN IMMEDIATE y después copié los archivos. Oracle cerró la base de forma limpia y deshizo las transacciones pendientes, por lo que la copia quedó consistente.

Si copiara los archivos directamente con la base abierta, podrían cambiar durante la copia y quedar en estados diferentes. Para hacer una copia en caliente utilizaría un procedimiento de respaldo de Oracle, como RMAN.

Referencia: 20261111T173912Z_00-backup-lab3.script.log, donde aparecen Database closed, Database dismounted y ORACLE instance shut down.

### 2. ¿Para qué sirven manifiesto.txt y SHA256SUMS? ¿Qué comprueba el guion de restauración?

manifiesto.txt describe la copia: su etiqueta, fecha, contenedor, volumen, imagen y commit, entre otros datos.

SHA256SUMS sirve para comprobar si los archivos han cambiado desde que se hizo la copia. Verifiqué las sumas y los cuatro archivos dieron OK.

Antes de parar la base o borrar el contenido del volumen, restaurar-estado.sh comprueba que Docker responde y verifica las sumas SHA-256. También muestra el manifiesto y pide confirmar el nombre del volumen, salvo que se utilice --si.

Referencia: manifiesto.txt y SHA256SUMS de backups/20261111T173913Z_lab3-final/, y el código de scripts/ops/restaurar-estado.sh.

### 3. Define RPO y RTO con los datos de tu copia

El RPO expresa cuánto tiempo de cambios se acepta perder al recuperar el servicio. Mi punto de recuperación disponible es la copia 20261111T173913Z_lab3-final: si la restaurara, perdería los cambios posteriores al estado guardado. No he definido un objetivo formal de RPO para este laboratorio.

El RTO es el tiempo objetivo para recuperar el servicio. Todavía no he realizado una restauración completa ni fijado ese objetivo, así que no tengo una duración de restauración con la que compararlo.

En el respaldo, la base volvió a estar disponible a los 10 segundos de arrancar el contenedor. Ese dato solo mide la espera del arranque y no incluye una restauración del volumen.

Referencia: 20261111T173912Z_00-backup-lab3.script.log, con t=10s docker=healthy cdb/pdb=READWRITE/READWRITE.

## Preguntas de comprobación — Diagnóstico y correcciones

### 4. ¿Dónde se crearon los datafiles de V000 y por qué? ¿Qué parámetro habría evitado el problema?

Los datafiles de negocio se crearon con rutas como:

/opt/oracle/product/26ai/dbhomeFree/dbs/academia01.dbf

V000 indicaba nombres de archivo sin una ruta completa y DB_CREATE_FILE_DEST estaba vacío. Por eso los archivos terminaron en $ORACLE_HOME/dbs.

El diagnóstico mostró que esa carpeta era un enlace a /opt/oracle/oradata/dbconfig/FREE/dbs. Por tanto, estaban dentro del volumen, aunque en una carpeta poco adecuada para los datos de negocio.

Para evitarlo, habría configurado DB_CREATE_FILE_DEST y utilizado OMF, o habría indicado rutas completas al crear los archivos.

Referencia: 20261111T175004Z_01-diagnostico.script.log, con las rutas originales, el enlace y db_create_file_dest vacío.

### 5. ¿Por qué RENAME DATAFILE no basta para mover un archivo?

Porque ALTER TABLESPACE ... RENAME DATAFILE cambia la ruta registrada en Oracle, pero no copia el archivo en el sistema operativo.

Puse el tablespace en OFFLINE, copié el archivo, actualicé la ruta y lo devolví a ONLINE. El guion eliminó el original después de que Oracle aceptara el archivo de destino.

Referencia: 20261111T175544Z_03-reubicar-datafiles.script.log, con la copia física y las rutas finales en /opt/oracle/oradata/FREE/FREEPDB1/.

### 6. ¿Por qué se crea V003 sin editar V000? ¿Por qué invalidar la contraseña?

V000 ya se había ejecutado. Si la modificara, el repositorio dejaría de reflejar exactamente la migración aplicada. Por eso utilicé una migración nueva para conservar el historial y aplicar la corrección en otros entornos.

Borrar una contraseña de un archivo tampoco la invalida: puede seguir apareciendo en commits anteriores o en otras copias. Con V003, las cuentas ADMIN\_\* pasaron a ser cuentas de solo esquema, por lo que sus antiguas contraseñas dejaron de servir para iniciar sesión.

Referencia: 20261111T180142Z_04-V003\_\_cuentas_esquema_sin_password.spool.log, donde las cinco cuentas muestran AUTHENTICATION_TYPE = NONE.

### 7. ¿Qué demuestra la prueba de persistencia y por qué se hace después de reubicar?

La prueba demuestra que los tablespaces y las tablas siguen disponibles al eliminar y recrear el contenedor conservando el volumen.

Se realiza después de reubicar para comprobar que las nuevas rutas funcionan y que los archivos necesarios están en el almacenamiento persistente.

Comparé el estado anterior y posterior: seguían los cinco tablespaces y los mismos recuentos de tablas por esquema. La tabla de estudiantes tenía 0 filas en ambos casos, ya que cargué V002 más tarde. Comprobé la persistencia de las estructuras; las 20.000 filas de V002 no formaban parte de esta prueba.

Referencia: 20261111T182852Z_03-prueba-persistencia.script.log, apartados ANTES y DESPUÉS.

## Preguntas de comprobación — Instancia y arranque

### 8. Tres datos de la instancia y tres de la base de datos

De la instancia obtuve:

- Nombre: FREE.
- Estado: OPEN.
- Fecha de arranque: 2026-11-14 09:15:00.

De la base de datos obtuve:

- DBID: 1510161217.
- Fecha de creación: 2026-07-08.
- Modo de registro: ARCHIVELOG.

La fecha de arranque cambia al reiniciar la instancia. El DBID y la fecha de creación identifican la base que permanece en el volumen.

Referencia: 20261114T092408Z_05-instancia-y-base.spool.log, consultas a V$INSTANCE y V$DATABASE.

### 9. ¿Qué lee Oracle en NOMOUNT, MOUNT y OPEN?

En NOMOUNT, Oracle lee la configuración de arranque, reserva memoria e inicia los procesos. Todavía no ha abierto los control files, por lo que consultar V$DATABASE devuelve ORA-01507.

En MOUNT, abre los control files y conoce los archivos de la base. El diccionario todavía no está accesible, por eso consultar DBA_TABLES devuelve ORA-01219.

En OPEN, abre los datafiles y los redo logs online, realiza la recuperación necesaria y permite acceder al diccionario y a los datos.

Referencia: 20261114T093634Z_06-arranque-por-etapas.script.log, donde aparecen ambos errores esperados y la apertura final en READ WRITE.

### 10. ¿Por qué FREEPDB1 se abre sola? ¿Qué harías si no se abriera?

FREEPDB1 se abre automáticamente porque tenía guardado su estado de apertura con SAVE STATE.

Si se quedara en MOUNTED, comprobaría el motivo y, desde CDB$ROOT, ejecutaría:

    ALTER PLUGGABLE DATABASE FREEPDB1 OPEN;
    ALTER PLUGGABLE DATABASE FREEPDB1 SAVE STATE;

Después comprobaría otra vez su estado.

Referencia: 20261114T093634Z_06-arranque-por-etapas.script.log, con FREEPDB1 en READ WRITE y su estado guardado como OPEN.

### 11. Clasifica ORA-00800 y ORA-20013

El enunciado describe ambos como avisos conocidos de esta imagen de laboratorio.

Encontré ORA-00800 [Set Priority Failed] para VKTM y LGWR. Oracle intentó aumentar su prioridad y las restricciones del contenedor lo impidieron. Comprobé después que la base y FREEPDB1 se abrieron correctamente.

ORA-20013 está relacionado con DBMS_QOPATCH y la consulta del inventario de parches de la imagen. El PDF lo clasifica como un aviso conocido, pero no lo encontré en el fragmento de alert log que guardé.

Referencia: 20261114T094059Z_06-alert-log.script.log, con los avisos ORA-00800 y Completed: ALTER DATABASE OPEN. La clasificación de ORA-20013 procede de la Parte E.3 del PDF.

## Preguntas de comprobación — Parámetros

### 12. Diferencia entre V$PARAMETER y V$SPPARAMETER

V$PARAMETER muestra los valores efectivos de los parámetros. V$SPPARAMETER permite consultar la configuración guardada en el SPFILE para los siguientes arranques.

Guardé db_files = 300 en el SPFILE y comprobé que en memoria seguía en 200. Como es un parámetro estático, el nuevo valor habría necesitado un reinicio.

Después ejecuté RESET: el valor en memoria continuó en 200 y el SPFILE dejó de tener una entrada explícita para ese parámetro.

Referencia: 20261114T095713Z_07-parametros-cambios.script.log, donde aparecen 200/300 y después 200/(no especificado).

### 13. ¿Qué hace SCOPE=BOTH? ¿Cuál es el alcance por defecto con SPFILE?

SCOPE=BOTH cambia el valor en memoria y lo guarda en el SPFILE, de modo que el cambio se aplica en ese momento y se conserva tras reiniciar.

Es también el alcance por defecto de ALTER SYSTEM SET cuando la instancia ha arrancado con SPFILE.

En el ejercicio, open_cursors pasó a 500 tanto en memoria como en el SPFILE. Después lo devolví a 300.

Referencia: 20261114T095713Z_07-parametros-cambios.script.log, apartado SCOPE=BOTH.

### 14. ¿Por qué PROCESSES rechaza el cambio en memoria aunque aparezca IMMEDIATE?

Aunque la vista muestre IMMEDIATE en esta versión, PROCESSES sigue necesitando un reinicio para aplicar el cambio. Intenté modificarlo con SCOPE=MEMORY y obtuve ORA-02095, acompañado de ORA-02097.

Por tanto, para cambiarlo tendría que guardar el nuevo valor con SCOPE=SPFILE y reiniciar la instancia. El resultado del ejercicio mostró que esa columna no bastaba para concluir que el cambio se podía hacer en memoria.

Referencia: 20261114T094412Z_07-parametros-lectura.spool.log y 20261114T095713Z_07-parametros-cambios.script.log.

### 15. ¿Para qué sirve versionar el PFILE? ¿Qué es configuration drift?

El PFILE es un archivo de texto que permite revisar la configuración y comparar sus cambios mediante Git. También puede servir como referencia para reconstruir una configuración válida.

El configuration drift es la diferencia que aparece entre la configuración documentada y la que realmente utiliza el entorno cuando se hacen cambios sin registrarlos.

Guardé una exportación desde SPFILE y otra desde memoria, con 32 y 122 líneas respectivamente.

Referencia: 20261114T095923Z_07-pfile.script.log y los archivos initFREE_lab4.ora e initFREE_lab4_memoria.ora.

## Preguntas de comprobación — Memoria y procesos

### 16. ¿Qué modelo de gestión de memoria usa la instancia?

Identifiqué ASMM al consultar estos tres parámetros:

- MEMORY_TARGET = 0: no está activa la gestión conjunta de SGA y PGA mediante AMM.
- SGA_TARGET = 1536M: Oracle gestiona automáticamente el reparto de la SGA.
- PGA_AGGREGATE_TARGET = 512M: la PGA tiene un objetivo independiente.

Referencia: 20261114T100358Z_08-memoria.spool.log, apartado de parámetros de memoria.

### 17. Explica las cifras del experimento de caché

Las dos consultas devolvieron 17.600 estudiantes activos.

Obtuve 463 lecturas lógicas y 265 físicas en la primera ronda. En la segunda obtuve 247 lógicas y 0 físicas: la consulta aprovechó los bloques que ya estaban en memoria.

Las lecturas lógicas representan accesos a bloques a través de la memoria de Oracle. Las físicas requieren traer bloques desde el almacenamiento.

Las lecturas lógicas fueron distintas entre rondas, a diferencia del ejemplo del PDF. La medición recoge estadísticas de la sesión; no comprobé qué parte de la diferencia correspondía a otras operaciones.

La tasa de acierto de la segunda ronda fue:

1 − físicas/lógicas = 1 − 0/247 = 100 %

Referencia: 20261114T100500Z_08-experimento-cache.script.log, con los resultados de ambas rondas y 245 bloques de la tabla en caché.

### 18. ¿Por qué no se suma el RSS de los procesos?

Porque los procesos de Oracle comparten la SGA. Esa memoria puede aparecer en el RSS de varios procesos, por lo que sumarlos contaría repetidamente parte de la misma memoria.

Para estudiar el consumo utilizaría las vistas de SGA y PGA, junto con la medición del contenedor, teniendo en cuenta qué mide cada dato.

Referencia: 20261114T143137Z_09-procesos-so.script.log, que muestra el RSS por proceso, y 20261114T100358Z_08-memoria.spool.log, con las medidas de SGA y PGA.

### 19. Relaciona el SPID de LGWR con el PID de /proc

Consulté V$PROCESS y obtuve el SPID 1942 para LGWR. Después ejecuté el guion de Linux con ese número y encontré db_lgwr_FREE con el mismo PID.

docker top puede mostrar otro número porque utiliza el espacio de identificadores del anfitrión de Docker. Oracle muestra el identificador que ve dentro del contenedor.

Referencia: 20261114T142305Z_09-procesos.spool.log, fila LGWR 1942, y 20261114T143137Z_09-procesos-so.script.log, fila 1942 ... db_lgwr_FREE.

### 20. ¿Qué hace PMON y qué hace SMON?

PMON se ocupa de detectar procesos que han fallado y coordinar su limpieza. Por ejemplo, si desaparece un proceso servidor con una transacción pendiente, la limpieza permite liberar sus recursos y bloqueos.

SMON interviene en la recuperación de la instancia y realiza tareas de mantenimiento. Por ejemplo, después de una parada brusca participa en la recuperación necesaria al arrancar.

Encontré ambos procesos en la consulta. Sus funciones las expliqué a partir del enunciado; no provoqué su fallo.

Referencia: 20261114T143137Z_09-procesos-so.script.log, con db_pmon_FREE y db_smon_FREE.

## Preguntas de comprobación — Seguridad y trabajo profesional

### 21. ¿Por qué utilizar C##OPS_RO en lugar de SYSTEM? ¿Qué no puede hacer?

Utilicé C##OPS_RO para consultar el estado de Oracle con menos privilegios que SYSTEM. Le concedí permisos para iniciar sesión, cambiar de contenedor y consultar el catálogo.

Los permisos concedidos no incluyen administrar la instancia, ejecutar ALTER SYSTEM, crear usuarios ni modificar las tablas de negocio. Así evito utilizar una cuenta administrativa para las consultas de observación.

Referencia: scripts/lab4/02-cuenta-observabilidad.sql, con los permisos concedidos, y 20261114T092408Z_05-instancia-y-base.spool.log, donde las consultas se ejecutan como C##OPS_RO.

### 22. ¿Qué dos vías de exposición de contraseñas se corrigen respecto al Lab 3?

La primera es guardar contraseñas de los propietarios de los esquemas en los archivos SQL versionados. V003 convierte las cuentas ADMIN\_\* en cuentas sin autenticación, de modo que las contraseñas anteriores dejan de permitir el inicio de sesión.

La segunda es pasar la contraseña de SYS en la conexión de los guiones, con expresiones como sys/<contraseña>. El guion de migraciones utiliza ahora autenticación del sistema operativo dentro del contenedor mediante / as sysdba.

Las contraseñas que siguen siendo necesarias se mantienen en config/.env, que está excluido de Git. Comprobé las dos contraseñas en los archivos versionados y en el historial local de Git. Ambas búsquedas dieron 0 coincidencias. También comprobé que config/.env, backups/ y los archivos .tar.gz quedaban fuera de Git.

Referencia: 20261111T180142Z_04-V003\_\_cuentas_esquema_sin_password.spool.log y el código de scripts/deployment/env/08-aplicar-migraciones.sh.
