# Módulos usados
- network-repo
- compute-repo
- storage-repo

# Control de versiones
Estructura base: 
> `Version: v-x.x`\
`Fecha: (dd-mm-aa)`\
`Autor: <(Apellido_autor)-(user_github)>`\
`Detalle: <Descripción de la versión>`\
`Arbol actual: <imagen_del_directorio_actual>`

---
## V-0.0
> **Fecha**: 07-06-2025\
**Autor**: Luna-Chriss5-2\
**Detalle**:\
Creación de módulos `compute_repo`, `network_repo` y `storage-repo` con archivos `main.tf`, `variables.tf`, `outputs.tf` y `CHANGELOG.md`además de que cada módulo se inicializó como repositorio\
Creación del repositorio `umbrella-repo`, agregar las carpetas `compute_repo`, `network_repo` y `storage-repo` como submodulos\
Creación de la carpeta `scripts` con el archivo `update_all.sh` el cuál tiene como script base la actualización de submódulos según su último commit\
Creación del archivo `umbrella/README.md` que contendrá información de las versiones y los changelogs\
**Arbol actual**
```bash
multirepo
    ├───compute-repo
    |   ├───CHANGELOG.md
    |   ├───main.tf
    |   ├───outputs.tf
    |   └───variables.tf
    ├───network-repo
    |   ├───CHANGELOG.md
    |   ├───main.tf
    |   ├───outputs.tf
    |   └───variables.tf
    ├───storage-repo
    |   ├───CHANGELOG.md
    |   ├───main.tf
    |   ├───outputs.tf
    |   └───variables.tf
    └───umbrella-repo
        ├───compute-repo    ← submódulo
        ├───network-repo    ← submódulo
        ├───scripts
        |   └───update_all.sh
        ├───storage-repo    ← submódulo
        └───umbrella
            └───README.md
```
---
---
## V-0.1
> **Fecha**: 17-06-2025\
**Autor**: Luna-Chriss5-2\
**Detalle**:\
- Actualizar estructura similar de multirepo para que quede similar a la de monorepo, modificando los archivos de los repositorios `compute_repo`, `network_repo` y `storage-repo` 
- Finalización del archivo update_all.sh para que además de actualizar los submódulos de acuerdo a su último commit, actualice el submódulos de acuerdo al último tag realizado en su respectivo repositorio, para así empezar con un manejo del versionamiento semántico de submódulos en multirepo el cuál es el tema principal del proyecto
- Crear el archivo umbrella/update.log en el cuál se guardarán todas las respuestas de salida obtenidas al ejecutar el script **update_all.sh**
- Agregación del script **network_tool.sh** que como en la rúbrica no indice que hace exactamente, solo ejecutará una impresión en la pantalla ```echo "Creación base de la red"```
- Creación del tag **v-0.1** sobre cada respositorio `compute_repo`, `network_repo` y `storage-repo` el cuál apunta a la versión final actual donde se tiene que los repositorios ya tienen listo sus dependencias y una infraestructura funcional
- Creación de la variable **instance_count** para `compute-repo` el cuál llevará una contabilización de las instancias creadas (por ahora tiene solo valor por defecto) y el output **storage_path** para `storage-repo` el cuál indicará una ruta de una carpeta encargada de guardar los datos de la base de datos que se encarga de crear
**Arbol actual**
```bash
multirepo
    ├───compute-repo
    |   ├───CHANGELOG.md
    |   ├───main.tf
    |   ├───outputs.tf
    |   └───variables.tf
    ├───network-repo
    |   ├───CHANGELOG.md
    |   ├───main.tf
    |   ├───outputs.tf
    |   └───variables.tf
    ├───storage-repo
    |   ├───CHANGELOG.md
    |   ├───main.tf
    |   ├───outputs.tf
    |   └───variables.tf
    └───umbrella-repo
        ├───compute-repo    ← submódulo
        ├───network-repo    ← submódulo
        ├───scripts
        |   └───update_all.sh
        ├───storage-repo    ← submódulo
        └───umbrella
            ├───repots
            |   └───update.logs
            └───README.md
```
---
---
## V-0.2
> **Fecha**: 19-06-2025\
**Autor**: Luna-Chriss5-2\
**Detalle**:\
- Implementación del script **rollback.sh** el cuál tendrá como objetivo el versionamiento de submódulos, con 4 opciones disponibles `Roll back al último tag semántico`, `Roll back a un tag específico`, `Mantener el estado actual y cambiar de módulo` y por último `Sair del rollback`
- Implementación del script **simular_drift** el cuál tendrá como objetivo, levantar la infraestructura de cada submódulos, luego realizar un cambio "manual" en el interior de la infraestructura ya creada, para al último realizar `terraform plan` y verificar el aviso de drift por cambiar los parámetros creados anteriormente por la infraestructura actual en ejecución
- Agregar triggers de los archivos **main.tf** de los submódulos `compute_repo`, `network_repo` y `storage-repo` para de esta manera, poder facilitar la modificación del archivo **terraform.tfstate** y poder realizar el script **simular_drift** de manera efectiva
- Agregación de la carpeta `enviroments` con las subcarpetas `iac\multirepo\umbrella-repo\enviroments\python` (aún no implementado), `iac\multirepo\umbrella-repo\enviroments\terraform\source_path` y `iac\multirepo\umbrella-repo\enviroments\terraform\source_repository` para mostrar las distintas formas de ejecutar la creación de módulos con los submódulos creados, siendo la primera forma, que el **source** del modulo apunte directamente al path actual `source_path` o la segunda forma se basa en que el **source** del módulo, apuntará directamente a la ruta del repositorio github sobre el que se encuentra creado `source_repository`
- Agregar `tests\test_drift.py` el cuál se encargará de testear el script `simular_drift.py` usando pytest
**Arbol actual**
```bash
    multirepo
    │   .gitignore
    │   .gitmodules
    │
    ├───.pytest_cache
    │   │   .gitignore
    │   │   CACHEDIR.TAG
    │   │   README.md
    │   │
    │   └───v
    │       └───cache
    │               lastfailed
    │               nodeids
    │               stepwise
    │
    ├───compute-repo
    │       CHANGELOG.md
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───enviroments
    │   ├───python
    │   └───terraform
    │       ├───source_path
    │       │       main.tf
    │       │
    │       └───source_repository
    │               main.tf
    │
    ├───network-repo
    │       CHANGELOG.md
    │       main.tf
    │       network_tool.sh
    │       outputs.tf
    │       variables.tf
    │
    ├───scripts
    │       rollback.sh
    │       simular_drift.sh
    │       update_all.sh
    │
    ├───storage-repo
    │       CHANGELOG.md
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───tests
    │       test_drift.py
    │
    └───umbrella
        │   README.md
        │
        └───reports
                update.log
```