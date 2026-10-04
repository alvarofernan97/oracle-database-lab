(base) alvaro@MacBook-Pro-de-Alvaro desktop % git --version
git version 2.55.0
(base) alvaro@MacBook-Pro-de-Alvaro desktop % cd ~/desktop/dev/
(base) alvaro@MacBook-Pro-de-Alvaro dev % mkdir oracle-database-lab
(base) alvaro@MacBook-Pro-de-Alvaro dev % cd oracle-database-lab
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % ls -la
total 0
drwxr-xr-x 2 alvaro staff 64 4 oct. 10:02 .
drwx------@ 23 alvaro staff 736 4 oct. 10:02 ..
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git init
hint: Using 'master' as the name for the initial branch. This default branch name
hint: will change to "main" in Git 3.0. To configure the initial branch name
hint: to use in all of your new repositories, which will suppress this warning,
hint: call:
hint:
hint: git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint: git branch -m <name>
hint:
hint: Disable this message with "git config set advice.defaultBranchName false"
Inicializado repositorio Git vacío en /Users/alvaro/Desktop/DEV/oracle-database-lab/.git/
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % ls -la
total 0
drwxr-xr-x 3 alvaro staff 96 4 oct. 10:03 .
drwx------@ 23 alvaro staff 736 4 oct. 10:02 ..
drwxr-xr-x@ 9 alvaro staff 288 4 oct. 10:03 .git
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master

No hay commits todavía

no hay nada para confirmar (crea/copia archivos y usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % mkdir -p database/schema database/migrations database/rollback database/test
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % mkdir -p scripts runbooks playbooks docs
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % touch Readme.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master

No hay commits todavía

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
Readme.md

no hay nada agregado al commit pero hay archivos sin seguimiento presentes (usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % touch runbooks/.gitkeep playbooks/.gitkeep database/schema/.gitkeep database/migrations/.gitkeep database/rollback/.gitkeep database/tests/.gitkeep scripts/.gitkeep
touch: database/tests/.gitkeep: No such file or directory
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master

No hay commits todavía

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
Readme.md
database/
playbooks/
runbooks/
scripts/

no hay nada agregado al commit pero hay archivos sin seguimiento presentes (usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % touch database/tests/.gitkeep
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master

No hay commits todavía

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
Readme.md
database/
playbooks/
runbooks/
scripts/

no hay nada agregado al commit pero hay archivos sin seguimiento presentes (usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git config --global status.showUntrackedFiles all
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master

No hay commits todavía

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
README.md
database/.DS_Store
database/migrations/.gitkeep
database/rollback/.gitkeep
database/schema/.gitkeep
database/tests/.gitkeep
playbooks/.gitkeep
runbooks/.gitkeep
scripts/.gitkeep

no hay nada agregado al commit pero hay archivos sin seguimiento presentes (usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git add README.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master

No hay commits todavía

Cambios a ser confirmados:
(usa "git rm --cached <archivo>..." para sacar del área de stage)
nuevos archivos: README.md

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
database/.DS_Store
database/migrations/.gitkeep
database/rollback/.gitkeep
database/schema/.gitkeep
database/tests/.gitkeep
playbooks/.gitkeep
runbooks/.gitkeep
scripts/.gitkeep

(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git diff --staged
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..e8c0a35
--- /dev/null
+++ b/README.md
@@ -0,0 +1,6 @@
+# Oracle Database Lab

- +Training repository for Oracle Database administration, testing, change management and Git workflows.
- +Name: Álvaro Fernández Morales
  +Professor: Richard Aviles Lopez
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "docs: add initial project documentation"
  [master (commit-raíz) 90b4986] docs: add initial project documentation
  1 file changed, 6 insertions(+)
  create mode 100644 README.md
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
  En la rama master
  Archivos sin seguimiento:
  (usa "git add <archivo>..." para incluirlo a lo que será confirmado)
  .DS_Store
  database/.DS_Store
  database/migrations/.gitkeep
  database/rollback/.gitkeep
  database/schema/.gitkeep
  database/tests/.gitkeep
  playbooks/.gitkeep
  runbooks/.gitkeep
  scripts/.gitkeep

no hay nada agregado al commit pero hay archivos sin seguimiento presentes (usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git log
commit 90b498604d86f8d8675d5b4a3b70959d35e54e95 (HEAD -> master)
Author: Alvaro Fernandez <afernandez354@alu.ucam.edu>
Date: Sun Oct 4 10:11:57 2026 +0200

    docs: add initial project documentation

(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % echo "# Database schema notes" > docs/customer-schema.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "docs: add customer schema notes"
En la rama master
Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
database/.DS_Store
database/migrations/.gitkeep
database/rollback/.gitkeep
database/schema/.gitkeep
database/tests/.gitkeep
docs/customer-schema.md
playbooks/.gitkeep
runbooks/.gitkeep
scripts/.gitkeep

no hay nada agregado al commit pero hay archivos sin seguimiento presentes (usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master
Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
database/.DS_Store
database/migrations/.gitkeep
database/rollback/.gitkeep
database/schema/.gitkeep
database/tests/.gitkeep
docs/customer-schema.md
playbooks/.gitkeep
runbooks/.gitkeep
scripts/.gitkeep

no hay nada agregado al commit pero hay archivos sin seguimiento presentes (usa "git add" para hacerles seguimiento)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git log --oneline
90b4986 (HEAD -> master) docs: add initial project documentation
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git add docs/customer-schema.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "docs: add customer schema notes"
[master b5e8bd8] docs: add customer schema notes
1 file changed, 1 insertion(+)
create mode 100644 docs/customer-schema.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git log --oneline
b5e8bd8 (HEAD -> master) docs: add customer schema notes
90b4986 docs: add initial project documentation
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % echo "Some content" >> docs/customer-schema.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git add docs/customer-schema.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "dcos: fxi typo"
[master e8144d8] dcos: fxi typo
1 file changed, 1 insertion(+)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit --amend -m "docs: fix typo in schema notes"
[master 8ae4f12] docs: fix typo in schema notes
Date: Sun Oct 4 10:17:48 2026 +0200
1 file changed, 1 insertion(+)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git log --oneline
8ae4f12 (HEAD -> master) docs: fix typo in schema notes
b5e8bd8 docs: add customer schema notes
90b4986 docs: add initial project documentation
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git branch

- master
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch -c feature/customer-search
  Cambiado a nueva rama 'feature/customer-search'
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git branch
- feature/customer-search
  master
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % ls -la
  total 32
  drwxr-xr-x@ 10 alvaro staff 320 4 oct. 10:08 .
  drwx------@ 23 alvaro staff 736 4 oct. 10:02 ..
  -rw-r--r--@ 1 alvaro staff 8196 4 oct. 10:07 .DS_Store
  drwxr-xr-x@ 13 alvaro staff 416 4 oct. 10:20 .git
  drwxr-xr-x 7 alvaro staff 224 4 oct. 10:07 database
  drwxr-xr-x 3 alvaro staff 96 4 oct. 10:15 docs
  drwxr-xr-x 3 alvaro staff 96 4 oct. 10:06 playbooks
  -rw-r--r--@ 1 alvaro staff 191 4 oct. 10:10 README.md
  drwxr-xr-x 3 alvaro staff 96 4 oct. 10:06 runbooks
  drwxr-xr-x 3 alvaro staff 96 4 oct. 10:06 scripts
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % echo "Draft: customer search notes" > docs/customer-search.md
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git add docs/customer-search.md
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "docs: draft customer search notes"
  [feature/customer-search 4b55262] docs: draft customer search notes
  1 file changed, 1 insertion(+)
  create mode 100644 docs/customer-search.md
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git log --oneline --graph --all
- 4b55262 (HEAD -> feature/customer-search) docs: draft customer search notes
- 8ae4f12 (master) docs: fix typo in schema notes
- b5e8bd8 docs: add customer schema notes
- 90b4986 docs: add initial project documentation
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch
  fatal: falta branch o commit como argumento
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch main
  fatal: referencia inválida: main
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch master
  Cambiado a rama 'master'
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % ls docs/
  customer-schema.md
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch feature/customer-search
  Cambiado a rama 'feature/customer-search'
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % ls docs/
  customer-schema.md customer-search.md
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git branch -d branch-de-prueba
  error: branch 'branch-de-prueba' not found
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch master
  Cambiado a rama 'master'
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch -c fix/readme-title
  Cambiado a nueva rama 'fix/readme-title'
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
  En la rama fix/readme-title
  Cambios no rastreados para el commit:
  (usa "git add <archivo>..." para actualizar lo que será confirmado)
  (usa "git restore <archivo>..." para descartar los cambios en el directorio de trabajo)
  modificados: README.md

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
database/.DS_Store
database/migrations/.gitkeep
database/rollback/.gitkeep
database/schema/.gitkeep
database/tests/.gitkeep
playbooks/.gitkeep
runbooks/.gitkeep
scripts/.gitkeep

sin cambios agregados al commit (usa "git add" y/o "git commit -a")
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git add README.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama fix/readme-title
Cambios a ser confirmados:
(usa "git restore --staged <archivo>..." para sacar del área de stage)
modificados: README.md

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
database/.DS_Store
database/migrations/.gitkeep
database/rollback/.gitkeep
database/schema/.gitkeep
database/tests/.gitkeep
playbooks/.gitkeep
runbooks/.gitkeep
scripts/.gitkeep

(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "docs: rename project title (training edition)"
[fix/readme-title d5db3b1] docs: rename project title (training edition)
1 file changed, 1 insertion(+), 1 deletion(-)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status -c
error: switch desconocido `c'
uso: git status [<options>] [--] [<pathspec>...]

    -v, --[no-]verbose    ser verboso
    -s, --[no-]short      mostrar status de manera concisa
    -b, --[no-]branch     mostrar información de la rama
    --[no-]show-stash     mostrar información del stash
    --[no-]ahead-behind   calcular todos los valores delante/atrás
    --[no-]porcelain[=<versión>]
                          output en formato de máquina
    --[no-]long           mostrar status en formato largo (default)
    -z, --[no-]null       terminar entradas con NUL
    -u, --[no-]untracked-files[=<modo>]
                          mostrar archivos sin seguimiento, modos opcionales: all, normal, no. (Predeterminado: all)
    --[no-]ignored[=<modo>]
                          mostrar archivos ignorados, modos opcionales: traditional, matching, no. (Predeterminado: traditional)
    --[no-]ignore-submodules[=<cuando>]
                          ignorar cambios en submódulos, opcional cuando: all, dirty, untracked. (Default: all)
    --[no-]column[=<estilo>]
                          listar en columnas los archivos sin seguimiento
    --no-renames          no detectar renombrados
    --renames             opposite of --no-renames
    -M, --find-renames[=<n>]
                          detectar renombrados, opcionalmente configurar similaridad de índice

(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git swtich master
git: 'swtich' no es un comando de git. Mira 'git --help'.

El comando más similar es
switch
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch master
Cambiado a rama 'master'
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch -c fix/readme-subtitle
Cambiado a nueva rama 'fix/readme-subtitle'
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git add README.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "docs: rename project title (Academic Version)"
[fix/readme-subtitle 28d014e] docs: rename project title (Academic Version)
1 file changed, 1 insertion(+), 1 deletion(-)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch main
fatal: referencia inválida: main
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch master
Cambiado a rama 'master'
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git merge fix/readme-title
Actualizando 8ae4f12..d5db3b1
Fast-forward
README.md | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git merge fix/readme-subtitle
Auto-fusionando README.md
CONFLICTO (contenido): Conflicto de fusión en README.md
Fusión automática falló; arregle los conflictos y luego realice un commit con el resultado.
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git status
En la rama master
Tienes rutas no fusionadas.
(arregla los conflictos y ejecuta "git commit"
(usa "git merge --abort" para abortar la fusion)

Rutas no fusionadas:
(usa "git add <archivo>..." para marcar una resolución)
modificados por ambos: README.md

Archivos sin seguimiento:
(usa "git add <archivo>..." para incluirlo a lo que será confirmado)
.DS_Store
database/.DS_Store
database/migrations/.gitkeep
database/rollback/.gitkeep
database/schema/.gitkeep
database/tests/.gitkeep
playbooks/.gitkeep
runbooks/.gitkeep
scripts/.gitkeep

sin cambios agregados al commit (usa "git add" y/o "git commit -a")
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git add README.md
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git commit -m "merge:resolve README title conflict"
[master ddf7156] merge:resolve README title conflict
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git log --oneline --graph --all

- ddf7156 (HEAD -> master) merge:resolve README title conflict
  |\
  | \* 28d014e (fix/readme-subtitle) docs: rename project title (Academic Version)
- | d5db3b1 (fix/readme-title) docs: rename project title (training edition)
  |/
  | \* 4b55262 (feature/customer-search) docs: draft customer search notes
  |/
- 8ae4f12 docs: fix typo in schema notes
- b5e8bd8 docs: add customer schema notes
- 90b4986 docs: add initial project documentation
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git remote add origin https://github.com/alvarofernan97/oracle-database-lab.git
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git remote -v
  origin https://github.com/alvarofernan97/oracle-database-lab.git (fetch)
  origin https://github.com/alvarofernan97/oracle-database-lab.git (push)
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git branch -M master
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git push u- origin master
  error: src refspec origin no concuerda con ninguno
  error: falló el empuje de algunas referencias a 'u-'
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git push -u origin master
  Enumerando objetos: 20, listo.
  Contando objetos: 100% (20/20), listo.
  Compresión delta usando hasta 12 hilos
  Comprimiendo objetos: 100% (15/15), listo.
  Escribiendo objetos: 100% (20/20), 1.89 KiB | 1.89 MiB/s, listo.
  Total 20 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0)
  remote: Resolving deltas: 100% (4/4), done.
  To https://github.com/alvarofernan97/oracle-database-lab.git
- [new branch] master -> master
  rama 'master' configurada para rastrear 'origin/master'.
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git push -u origin fix/readme-title
  Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
  remote:
  remote: Create a pull request for 'fix/readme-title' on GitHub by visiting:
  remote: https://github.com/alvarofernan97/oracle-database-lab/pull/new/fix/readme-title
  remote:
  To https://github.com/alvarofernan97/oracle-database-lab.git
- [new branch] fix/readme-title -> fix/readme-title
  rama 'fix/readme-title' configurada para rastrear 'origin/fix/readme-title'.
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git push -u origin fix/readme-subtitle
  Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
  remote:
  remote: Create a pull request for 'fix/readme-subtitle' on GitHub by visiting:
  remote: https://github.com/alvarofernan97/oracle-database-lab/pull/new/fix/readme-subtitle
  remote:
  To https://github.com/alvarofernan97/oracle-database-lab.git
- [new branch] fix/readme-subtitle -> fix/readme-subtitle
  rama 'fix/readme-subtitle' configurada para rastrear 'origin/fix/readme-subtitle'.
  (base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % cat README.md

# Oracle Database Lab (Training edition -- Academic Version)

Training repository for Oracle Database administration, testing, change management and Git workflows.

Name: Álvaro Fernández Morales
Professor: Richard Aviles Lopez
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git switch fix/readme-subtitle
Cambiado a rama 'fix/readme-subtitle'
Tu rama está actualizada con 'origin/fix/readme-subtitle'.
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % git pull
Ya está actualizado.
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab % cat README.md

# Oracle Database Lab -- Academic Version

Training repository for Oracle Database administration, testing, change management and Git workflows.

Name: Álvaro Fernández Morales
Professor: Richard Aviles Lopez
(base) alvaro@MacBook-Pro-de-Alvaro oracle-database-lab %
