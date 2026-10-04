# Practica 1 : GIT Fundamentals

## ¿Cuál es la diferencia entre Working Directory, Staging Area y Local Repository? Da un ejemplo de un archivo pasando por las tres.

El Working directory es el area de trabajo donde estoy trabajando ahora mismo, su ubicacion. El staging area es una zona intermedia entre estas 2, en esta zona se incluyen las modificaciones y archivos que se van a incluir en el siguient commit y el Local repository es el repositorio de Git donde se guarda todo.

Si creamos un nuevo documento llamado lab1-respuestas.md al principio dicho documento estara en el working directory, una vez quiera subir dicho documento el archivo se enviara a Staging area y finalmente se subira al local repository.

## Si modificas un archivo pero no haces git add, ¿aparece ese cambio en tu próximo commit? Explica por qué.

No, al hacer commit solo se incluyen las modificaciones que previamente se han subido a Staging Area, los cambios unicamente aparecen en Working Directory.

## ¿Por qué git status no mostraba las carpetas vacías que creaste en la Parte C? ¿Qué truco usamos para solucionarlo?

Por que git no muestra carpetas, unicamente muestra archivos, para solucionar esto tenemos que añadir un .gitkeep

## Explica con tus palabras qué es HEAD

Es un puntero, muestra sobre que estamos trabajando, nos sirve para diferenciar entre los cambios en las ramas.

## ¿Qué diferencia hay entre crear una branch con git switch -c y crear una carpeta nueva con mkdir? ¿Cómo lo comprobamos en la Parte G?

git switch -c crea una branch nueva en Git y cambia directamente a esa branch.
Mkdir unicamente crea una nueva carpeta en el directorio de archivos.
En la parte G se comprueba ejecutando el comando ls -la al crear la feature/customer-search. La estructura de las carpetas es la misma, no aparece una carpeta nueva llamada feature.

## Durante el conflicto de la Parte H, ¿qué representaba el contenido entre <<<<<<< HEAD y =======? ¿ Y entre ======= y >>>>>>>?

<< HEAD ==== corresponde a la version que ya estaba incluida en la branch, en la rama master.

=== y >> son los cambios que vienen de la rama que tratamos de fusionar.

## ¿Por qué NO se debe hacer git commit --amend sobre un commit que ya se subió con git push?

por que --amend no modifica el commit, lo sustituye, se crea un hash diferente para cada uno.
-- ammend solo funciona con cambios no "pusheados"

## Si borras por accidente la carpeta .git de tu proyecto, ¿qué se pierde exactamente? ¿Se pierde también el código fuente que está en el disco?

al borrar .git se pierde toda la info que Git usa para gestionar el repositorio: Historial de commits, branches, referencias y configuracion local del repositorio.

## Explica con tus propias palabras la diferencia entre Git y GitHub, sin usar la palabra "nube"

Git es un sistema de control de verisones, el cual se ejecuta directamente en mi ordenador, si fuese un directorio de archivos git crearia una carpeta con cada nueva branch, con las modificaciones realizadas respecto a la carpeta anterior.

Github es una plataforma que permite visualizar los repositorios que tenemos de GIT, tambien permite trabajar con mas personas, haciendo proyectos colaborativos.

## ¿Por qué no se debe subir un archivo .env con contraseñas reales a un repositorio, aunque el repositorio sea privado?

Por seguridad, en cualquier momento puedes compartir el archivo a personas para que colaboren y estas pueden filtrar la contraseña. Aunque borres este env en cualquier momento pueden cambiar de version mediante Git y acceder a ella.

## Un compañero te dice: "hice push y ahora GitHub me rechaza el segundo push con 'non-fast- forward'". ¿Qué ha ocurrido probablemente y qué comando ejecutarías primero?

Seguramente el repositorio remoto tenga algun commit que no existe en el area de trabajo local, antes de hacer push haria pull para ver los cambios existentes entre la version remota y la version local y asi traerlos a la version local.
En caso de que exista algun conflicto lo soluciono primero y luego lo subo a Github.

## ¿Qué tipo de Conventional Commit (feat, fix, docs, test…) usarías para: añadir un índice de rendimiento a una tabla, corregir una restricción mal definida, y actualizar el README?

Para añadir un indice de rendimiento a una tabla usaria "perf".
Para corregir una restriccion mal definida usaria "fix".
Para actualizar el README usaria docs ya que unicamente se esta actualizando la documentacion.
