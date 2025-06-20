#!/bin/bash

set -e

echo "🔄 Rollback de submódulos al último tag semántico v-*  y ejecutando Terraform..."
SUBMODULES=("compute-repo" "network-repo" "storage-repo")

for MODULE in "${SUBMODULES[@]}"; do
    echo "📦 Procesando $MODULE..."

    cd "$MODULE"

    # Obtener tags desde el remoto
    git fetch --tags

    # Buscar el último tag semántico (v-*)
    LATEST_TAG=$(git tag -l 'v-*' --sort=-v:refname)

    if [ -z "$LATEST_TAG" ]; then
        echo "❌ No hay tags válidos en $MODULE"
        cd ..
        continue
    fi
    echo "-----------------------------------------------------"
    echo "-----------------------------------------------------"
    echo "✅ Tags disponibles para $MODULE:"
    echo "-----------------------------------------------------"
    echo $LATEST_TAG
    echo "-----------------------------------------------------"
    echo "|1.- Roll back al último tag semántico              |"
    echo "|2.- Roll back a un tag específico                  |"
    echo "|3.- Mantener el estado actual y cambiar de módulo  |"
    echo "|4.- Salir del rollback                             |"
    echo "-----------------------------------------------------"
    read -p "Selecciona una opción (1 o 4): " OPTION
    echo "-----------------------------------------------------"
    if [ "$OPTION" -eq 1 ]; then
        # Seleccionar el último tag semántico
        LATEST_TAG=$(echo "$LATEST_TAG" | head -n 1)
        git checkout "$LATEST_TAG"
        echo "✅ Rollback a $LATEST_TAG completado en $MODULE"
        
    elif [ "$OPTION" -eq 2 ]; then
        # Mostrar los tags disponibles y permitir al usuario seleccionar uno
        echo "Selecciona un tag para hacer rollback:"
        select TAG in $LATEST_TAG; do
            if [ -n "$TAG" ]; then
                LATEST_TAG="$TAG"
                break
            else
                echo "Selección inválida. Inténtalo de nuevo."
            fi
        done
        git checkout "$LATEST_TAG"
        echo "✅ Rollback a $LATEST_TAG completado en $MODULE"

    elif [ "$OPTION" -eq 3 ]; then
        echo "Manteniendo el estado actual y cambiando de módulo."
        echo "Levantando el siguiente módulo..."
    elif [ "$OPTION" -eq 4 ]; then
        echo "Saliendo sin hacer rollback."
        exit 0
    else
        echo "Opción no válida. Saliendo."
        exit 1
    fi



    if ls *.tf >/dev/null 2>&1; then
        echo "🚀 Ejecutando Terraform en $MODULE..."
        terraform init -input=false
        terraform apply -auto-approve
    else
        echo "⚠️ No hay archivos .tf en $MODULE, saltando Terraform."
    fi
    echo "--------------------------------------------------------"
    echo "--------------------------------------------------------"
    cd ..
done