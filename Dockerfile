FROM python:3.11-slim

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    wget gnupg unzip curl ca-certificates fonts-liberation \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libxcomposite1 \
    libxrandr2 libxdamage1 libxext6 libxfixes3 libxkbcommon0 \
    libx11-xcb1 libx11-6 libxcb1 libxrender1 libasound2 \
    libpangocairo-1.0-0 libgtk-3-0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Copia os arquivos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    playwright install --with-deps

COPY app/ ./app/
COPY start.sh .
RUN chmod +x start.sh

# Expõe a porta
EXPOSE 8000

# Comando de start
CMD ["./start.sh"]
