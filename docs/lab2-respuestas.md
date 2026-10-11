# Practica 2 : Lab 2 Github Team Workflow ADist.

## ¿Por qué un Issue sin criterios de aceptación es un problema, aunque la descripción general parezca clara?

Porque aunque la descripción explique lo que queremos hacer, si no hay criterios de aceptación no tenemos una forma clara de saber cuándo el trabajo está realmente terminado. Los criterios sirven como una lista de cosas que se tienen que cumplir y también ayudan al reviewer a comprobar si el cambio está completo.

## Explica la diferencia entre "Refs #N" y "Closes #N" en un mensaje de commit o en la descripción de un Pull Request.

Refs #N simplemente relaciona el commit o el Pull Request con el Issue indicado, pero no lo cierra.
En cambio, Closes #N indica que ese cambio resuelve el Issue. Cuando el Pull Request llega a main, GitHub cierra automáticamente ese Issue. También se pueden utilizar otras palabras como Fixes o Resolves.

## ¿Qué ocurre exactamente si intentas hacer git push directamente sobre una branch main protegida? ¿Es un error tuyo o un fallo del sistema?

GitHub rechaza el push porque la rama main está configurada para que los cambios tengan que entrar mediante un Pull Request.
No es un fallo del sistema, sino que la protección está funcionando correctamente. De hecho, en la práctica vimos el mensaje indicando que los cambios debían hacerse mediante un Pull Request.

## Un compañero te dice: "he aprobado el PR sin mirar los archivos, total ya me fío". ¿Qué riesgo tiene esa forma de revisar?

El problema es que puede aprobar un cambio que tenga errores, modificaciones accidentales o incluso algún problema de seguridad. El objetivo de la revisión no es solamente confiar en el compañero, sino comprobar realmente qué cambios se van a integrar en main.
Por eso es importante revisar Files changed antes de aprobar.

## Si el reviewer pide un cambio y tú ya habías hecho push de tu branch, ¿tienes que abrir un Pull Request nuevo? Explica qué ocurre técnicamente con el PR existente cuando haces un nuevo commit.

No hace falta abrir otro Pull Request.
Se modifica la misma branch, se hace otro commit y después otro push. Como el Pull Request está relacionado con esa branch, GitHub añade automáticamente el nuevo commit al mismo PR y actualiza también los archivos que aparecen en Files changed.
De esta forma no se pierde la conversación ni el historial de la revisión.

## Describe con tus palabras la diferencia entre Merge commit, Squash and merge y Rebase and merge. ¿Cuál usarías para una branch con commits "wip", "fix", "fix2", "ok ya"?

Merge commit conserva todos los commits de la branch y además crea un commit adicional para hacer la fusión.
Squash and merge junta todos los commits de la branch en uno solo antes de integrarlo en main.
Rebase and merge mueve los commits de la branch sobre main uno detrás de otro, sin crear un commit extra de merge.
Para una branch con commits como wip, fix, fix2 y ok ya, usaría Squash and merge, porque esos commits por separado no aportan mucho al historial y es mejor dejarlos como un único commit más limpio.

## ¿Por qué borrar una branch después del merge no elimina el trabajo realizado en ella?

Porque una vez que se hace el merge, los cambios y los commits ya están integrados en main.
La branch solo es una referencia a esa línea de trabajo. Al borrarla no desaparece lo que ya se ha fusionado, simplemente eliminamos una rama que ya no necesitamos.

## ¿Qué información debería contener siempre la descripción de un Pull Request, como mínimo?

Como mínimo debería explicar:

- Qué cambios se han realizado.
- Por qué se han realizado.
- Cómo se han probado.
- Qué Issue está relacionado con el cambio.
  Por ejemplo, en la práctica usamos las secciones Summary, Changes, Testing y Related Issue.

## Un reviewer escribe solo "esto está mal" como comentario. ¿Qué le falta a ese comentario para ser útil? Reescríbelo tú con un ejemplo inventado

Le falta explicar qué problema ha encontrado, por qué es importante y qué se podría hacer para solucionarlo.
Por ejemplo, en vez de:
Esto está mal.
podría poner:
issue (blocking): Falta validar que el usuario exista antes de guardar el pedido. Añadiría una comprobación para evitar guardar pedidos asociados a usuarios inexistentes.
De esta forma el autor sabe exactamente cuál es el problema y qué tiene que revisar

## ¿Qué diferencia hay entre que main esté protegida y que simplemente el equipo "se ponga de acuerdo" en no hacer push directo?

Si solamente nos ponemos de acuerdo, dependemos de que todas las personas recuerden y respeten esa norma.
Si main está protegida, GitHub hace cumplir esa regla automáticamente y puede impedir el push directo o exigir un Pull Request y una aprobación.
Por tanto, una cosa es una norma del equipo y otra es una norma que está aplicada técnicamente.

## Explica con un ejemplo propio la diferencia entre un comentario issue: (blocking) y uno nitpick: (if-minor) en formato Conventional Comments.

Un issue (blocking) indica que hay un problema que debe solucionarse antes de aprobar el Pull Request.
Por ejemplo:
issue (blocking): La contraseña se está guardando en texto plano. Debe almacenarse utilizando un hash antes de hacer merge.
En cambio, nitpick (if-minor) se utiliza para pequeños detalles que no deberían bloquear el PR.
Por ejemplo:
nitpick (if-minor): Cambiaría el nombre de esta variable de "x" a "userCount" para que sea más fácil entender el código.
El primero afecta a algo importante y el segundo es más bien una mejora pequeña de claridad o estilo.

## Si tu próximo commit es feat!: cambia la firma de la función principal de la API, ¿qué tipo de versión SemVer se dispara y por qué?

Se produciría un cambio de versión MAJOR.
El símbolo ! en feat!: indica que hay un breaking change, es decir, un cambio que rompe la compatibilidad con versiones anteriores.
Por ejemplo, si estábamos en la versión 2.1.0, podría pasar a 3.0.0.

## ¿Por qué abrir un Draft PR desde el primer commit estructural puede ahorrar tiempo al equipo, aunque parezca más lento para el autor individual?

Porque permite que otros miembros del equipo revisen la idea o el enfoque antes de que el autor haya terminado todo el trabajo.
Si hay algún problema importante con la forma de plantearlo, se puede detectar al principio y cambiarlo cuando todavía se ha invertido poco tiempo.
Aunque para el autor pueda parecer que pierde tiempo enseñando algo que todavía no está acabado, para el equipo puede evitar tener que rehacer muchas horas de trabajo más adelante.
