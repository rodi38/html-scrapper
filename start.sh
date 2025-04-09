#!/bin/bash

echo "Iniciando na porta: ${PORT:-8000}"

# Inicia o servidor Uvicorn na porta correta do Render (ou 8000 localmente)
uvicorn app.main:app --host 0.0.0.0 --port "${PORT:-8000}"
