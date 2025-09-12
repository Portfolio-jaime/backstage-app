
#!/bin/bash
# Script para iniciar Backstage usando Docker Compose y arrancar el frontend manualmente
# Autor: Jaime Henao
# Fecha: 12/09/2025

set -e

cd "$(dirname "$0")/../Docker"
echo "[1/4] Iniciando servicios con Docker Compose..."
docker-compose up -d

echo "[2/4] Accediendo al contenedor backstage-app..."
docker-compose exec backstage-app bash -c 'cd backstage && yarn start'

echo "[3/4] Backstage frontend iniciado manualmente."
echo "[4/4] Puedes acceder a la interfaz en http://localhost:3000"
