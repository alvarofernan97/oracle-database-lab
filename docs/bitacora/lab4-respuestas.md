# Lab 4:ORACLE DBA WORKFLOW I · RADIOGRAFÍA DE LA INSTANCIA

## Parte B — Respaldo del estado del Lab 3

### Punto de control: archivos fuera del volumen

En la ejecuccion se han detectado 0 archivos fuera del volumen.

Evidencia:
docs/bitacora/lab4/evidencia/script/20261111T173912Z_00-backup-lab3.script.log

La copia se ha guardado en:
backups/20261111T173913Z_lab3-final/

### Pregunta P1 — Copia tras SHUTDOWN IMMEDIATE

Respuestas correctas: A y D.

## Parte C — Correcciones del entorno

### Pregunta P2 — Reubicar un datafile

Respuesta correcta: B.

La secuencia es poner el tablespace OFFLINE, copiar físicamente
el archivo con el sistema operativo, actualizar su ruta mediante
ALTER TABLESPACE ... RENAME DATAFILE y devolverlo a ONLINE.

RENAME DATAFILE solo actualiza la referencia al archivo en Oracle;
no realiza la copia física. OFFLINE NORMAL permite copiarlo en un
estado consistente.

Este es el procedimiento utilizado en mi práctica para reubicar
los cinco datafiles de negocio en /opt/oracle/oradata/FREE/FREEPDB1/.

Evidencia:
docs/bitacora/lab4/evidencia/script/20261111T175544Z_03-reubicar-datafiles.script.log

## P3 — Instancia y base de datos

Respuestas correctas: A y C.

- A: STARTUP_TIME de V$INSTANCE cambia cada vez que se arranca
  la instancia. En mi caso muestra 2026-11-14 09:15:00.
- C: CREATED de V$DATABASE indica cuándo se creó la base,
  no cuándo arrancó la instancia. En mi caso muestra 2026-07-08.

B es falsa: recrear el contenedor Docker reutilizando la misma
base en el volumen no cambia su DBID.
D es falsa: una instancia no puede montar dos bases de datos
simultáneamente; las PDB pertenecen a la misma CDB.
E es falsa: V$DATABASE también se puede consultar en estado MOUNT.

## Parte E — Arranque por etapas y alert log

En NOMOUNT, V$PARAMETER responde porque los parámetros ya están
cargados en memoria. V$DATABASE devuelve ORA-01507 porque todavía
no se han abierto los control files.

En MOUNT, Oracle conoce los control files y los 16 datafiles.
DBA_TABLES devuelve ORA-01219 porque el diccionario almacenado
en SYSTEM todavía no está accesible.

Tras OPEN, FREE queda en READ WRITE. FREEPDB1 se abre automáticamente
en READ WRITE gracias a su estado guardado OPEN.

El alert log confirma la parada limpia y la apertura posterior.
Aparecen avisos ORA-00800 [Set Priority Failed] para VKTM y LGWR,
descritos en el enunciado, que no impiden abrir la base.

## P4 — Operaciones en NOMOUNT

Respuestas correctas: A y C.

Se puede consultar V$PARAMETER y recrear el control file mediante
CREATE CONTROLFILE. En esta etapa la instancia está arrancada,
pero la base todavía no está montada.

## P5 — Cambiar a ARCHIVELOG

Respuesta correcta: B, MOUNT.

Para ejecutar ALTER DATABASE ARCHIVELOG, la base debe estar
montada, pero no abierta.

## Parte F — Configuración y PFILE

La instancia utiliza SPFILE. La exportación desde SPFILE contiene
32 líneas y la exportación desde memoria, 122 líneas.

La configuración en memoria incluye valores derivados o por defecto
que no están escritos explícitamente en el SPFILE.

## P6 — SCOPE por defecto

Respuesta correcta: B.

Al arrancar con SPFILE, ALTER SYSTEM SET open_cursors = 500
utiliza SCOPE=BOTH por defecto: cambia el valor en memoria
y en el SPFILE, por lo que persiste tras reiniciar.

## P7 — PROCESSES desde una PDB

Respuesta correcta: C.

PROCESSES es un parámetro de instancia y no se puede modificar
desde FREEPDB1. La operación devuelve ORA-65040, como se ha
comprobado en el ejercicio.

## P8 — Recuperación ante un SPFILE incorrecto

Respuestas correctas: A y C.

STARTUP PFILE='/ruta/init_bueno.ora' permite arrancar utilizando
una configuración válida.

CREATE SPFILE FROM PFILE='/ruta/init_bueno.ora' permite reconstruir
el SPFILE a partir de esa configuración para futuros arranques.

## Parte G — Memoria y experimento de caché

La instancia utiliza ASMM, con SGA_TARGET = 1536M.
La PGA se gestiona aparte, con PGA_AGGREGATE_TARGET = 512M
y PGA_AGGREGATE_LIMIT = 2G.

DB_CACHE_SIZE = 0 permite que ASMM determine el tamaño
del buffer cache, sin un mínimo fijado manualmente.

### Interpretación del experimento

Ambas rondas devuelven 17.600 estudiantes activos.

- Caché fría: 463 lecturas lógicas y 265 físicas.
- Caché caliente: 247 lecturas lógicas y 0 físicas.
- Bloques de ACA_ESTUDIANTES en caché al terminar: 245.
- Tasa de acierto de la segunda ronda: 1 − 0/247 = 100 %.

La segunda ejecución aprovecha los bloques cargados en memoria.
Las cifras de la primera ronda incluyen trabajo adicional de
la sesión; por eso difieren del ejemplo ilustrativo del PDF.

Las 244 unidades de BLOCKS corresponden a estadísticas de la
tabla. Los 245 bloques observados en caché son coherentes con
los bloques de datos y la cabecera del segmento.

## P9 — ASMM y DB_CACHE_SIZE

Respuesta correcta: B.

ASMM gestiona la SGA. Con DB_CACHE_SIZE = 512M se fija
un mínimo para el buffer cache, que puede crecer por encima
de ese valor.

## P10 — Estructuras de la PGA

Respuestas correctas: A y D.

El área de ordenación y la memoria de sesión de un servidor
dedicado forman parte de su PGA.

Shared pool, log buffer y buffer cache pertenecen a la SGA.
