#!/bin/bash

# Instala navegadores Playwright (Chromium, Firefox, WebKit)
playwright install --with-deps

# Inicia a aplicação FastAPI
uvicorn app.main:app --host 0.0.0.0 --port 8000
