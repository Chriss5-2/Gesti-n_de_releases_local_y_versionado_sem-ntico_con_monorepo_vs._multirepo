# Práctica Calificada 3

## Estudiante
Christian Giovanni Luna Jaramillo

## Correo Institucional
christian.luna.j@uni.pe

## Número de Proyecto
Proyecto 13

## Título del proyecto grupal
Gestión de releases local y versionado semántico con monorepo vs. multirepo

## URL - Repositorio Grupal
https://github.com/grupo10-CC3S2/Proyecto13-PC3

## Descripción del rol
- Me encargué de implementar todo lo referente a multirepo, tanto como los repositorios, submódulos que abarca, los scripts de automatización y las pruebas de pytest para probar el archivo `simular_drift.sh`

# Instrucciones para clonar el repositorio y reproducir del código
Lo que personalmente recomiendo, sería estar en la rama raíz de desde ahí aplicar la clonación

```bash
# Clonar repositorio
git clone https://github.com/grupo10-CC3S2/umbrella-repo.git
cd umbrella-repo

# Inicializar y clonar los submódulos
git submodule update --init --recursive

cd .. # Para ubicarnos en el directorio raíz

# Instalar pytest
python -m venv pr_ind
# Linux
source pr_ind/Scripts/activate
# Windows
.\pr_ind\Scripts\activate
# Instalar requirements.txt
pip install -r requirements.txt

cd umbrella-repo # Volver al repositorio umbrella-repo

# Recomendaciones: 
# 1.- Si se está en windows, ejecutar
git bash 
# En caso esté en Linux no realizar este paso
# 2.- Luego de ejecutar el script, personalmente recomiendo eliminar los archivos .terraform, .terraform.lock.hcl y terraform.state generadas en 'compute-repo', 'network-repo' y 'storage-repo' para evitar que se creen duplicados con los demás scripts y haga fallar su ejecución

# Ejecutar update_all.sh
bash scripts/update_all.sh
# Realizar la recomendación 2

# Ejecutar rollback.sh
bash scripts/rollback.sh
# Luego elegir la opción que desea realizar
# Opción 1: Actualizar todoos los submódulos al último tag (similar a update_all.sh)
# Opción 2: Elegir una versión en específico sobre el cuál queremos actualizar el submódulo
    # Si se escocge esta opción, debemos ingresar la opción del tag al que queremos ir, NO INGRESAR 'v-0.x' O ALGO PARECIDO, SOLO '1', '2', etc, de acuerdo al número de tags que se tenga
# Opción 3: Mantener el submódulo a su estado actual y pasar al siguiente submódulo
# Opción 4: Salir del rollback
# Realizar la recomendación 2

# Ejecutar simular_drift.sh
bash scripts/simular_drift.sh

# Ejecutar test_drift.py
pytest tests/test_drift.py

# Ejecutar infraestructura principal de umbrella-repo con módulos y submódulos
cd enviroments/terraform/

# Módulos apuntando a submódulos
cd source_path/
terraform init
terraform apply -auto-approve

# Módulos apuntando a repositorios Github
cd ..
cd source_repository
# A veces tiene problemas con la ruta así que este comando permite evitar ese problema
git config --global core.longpaths true
terraform init
terraform applt -auto-approve

```