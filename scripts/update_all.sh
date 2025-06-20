#!/bin/bash

set -e

Log_Path="../umbrella/reports"
Log_File="$Log_Path/update.log"

mkdir -p "$Log_Path"
: > "$Log_File"

echo "🔄 Actualizando submódulos al último tag semántico v-* y ejecutando Terraform..." | tee -a "$Log_File"

SUBMODULES=("compute-repo" "network-repo" "storage-repo")

for MODULE in "${SUBMODULES[@]}"; do
    echo "📦 Procesando $MODULE..." | tee -a "$Log_File"

    cd "$MODULE"
    
    git fetch --tags >> "$Log_File" 2>&1

    LATEST_TAG=$(git tag -l 'v-*' --sort=-v:refname | head -n 1)

    if [ -z "$LATEST_TAG" ]; then
        echo "❌ No hay tags válidos en $MODULE" | tee -a "$Log_File"
        cd ..
        continue
    fi

    echo "✅ Último tag: $LATEST_TAG" | tee -a "$Log_File"
    git checkout "$LATEST_TAG"  >> "$Log_File" 2>&1

    # Ejecutar terraform solo si hay archivos .tf
    if ls *.tf >/dev/null 2>&1; then
        echo "🚀 Ejecutando Terraform en $MODULE..." | tee -a "$Log_File"
        terraform init -input=false | tee -a "$Log_File"
        terraform apply -auto-approve | tee -a "$Log_File"
    else
        echo "⚠️ No hay archivos .tf en $MODULE, saltando Terraform." | tee -a "$Log_File"
    fi

    cd ..
done

echo "✅ Todos los submódulos actualizados al último tag semántico" | tee -a "$Log_File"
