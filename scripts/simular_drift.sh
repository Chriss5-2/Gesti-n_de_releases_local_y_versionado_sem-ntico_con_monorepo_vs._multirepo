#!/bin/bash
set -e

echo "🔄 Simulando drift de submódulos al último tag semántico v-* y ejecutando Terraform..."

SUBMODULES=("compute-repo" "network-repo" "storage-repo")

for MODULE in "${SUBMODULES[@]}"; do
    echo "-----------------------------------------------"
    echo "📦 Procesando $MODULE..."

    cd "$MODULE" || { echo "❌ No se pudo entrar a $MODULE"; exit 1; }

    if [ ! -f "main.tf" ]; then
        echo "⚠️ No se encontró main.tf en $MODULE, se omite."
        cd ..
        continue
    fi

    echo "🚀 Ejecutando terraform init..."
    terraform init -input=false #> /dev/null

    echo "✅ Ejecutando terraform apply para generar estado..."
    terraform apply -auto-approve #> /dev/null

    STATE_FILE="terraform.tfstate"
    if grep -q '"version": "v1"' "$STATE_FILE"; then
        echo "💥 Simulando drift: cambiando version 'v1' → 'v2' en el estado..."
        sed -i.bak 's/"version": "v1"/"version": "v2"/' "$STATE_FILE"
    else
        echo "⚠️ No se encontró '\"version\": \"v1\"' en $STATE_FILE. Drift no simulado."
    fi

    echo "📋 Mostrando plan de drift en $MODULE..."
    terraform plan 

    echo "🧹 Limpiando archivos generados..."
    rm -rf .terraform terraform.tfstate terraform.tfstate.back .terraform.lock.hcl *.bak

    cd ..
done

echo ""
echo "✅ Simulación de drift completada en todos los submódulos."