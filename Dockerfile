# Imagen base con Node.js + sistema completo
FROM node:20-bullseye

# Instalamos dependencias de sistema necesarias para Playwright
RUN apt-get update && \
    apt-get install -y wget gnupg ca-certificates curl fonts-liberation libasound2 libatk1.0-0 libc6 \
    libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libglib2.0-0 libgtk-3-0 libnss3 \
    libnspr4 libpango-1.0-0 libx11-6 libx11-xcb1 libxcomposite1 libxdamage1 libxext6 libxfixes3 \
    libxrandr2 libxshmfence1 libxss1 libxtst6 lsb-release xdg-utils libgbm1 && \
    rm -rf /var/lib/apt/lists/*

# Instalamos n8n globalmente
RUN npm install -g n8n

# Instalamos Playwright y Chromium
RUN npm install -g playwright && \
    npx playwright install chromium

# Creamos carpeta de trabajo
WORKDIR /data

# Copiamos scripts personalizados (opcional)
COPY scripts/ /data/scripts/

# Exponemos el puerto
EXPOSE 5678

# Variables de entorno (puedes sobreescribirlas en el panel de Railway/Fly)
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=admin
ENV N8N_ENCRYPTION_KEY=1234567890abcdef
ENV PLAYWRIGHT_HEADLESS=true

# Iniciamos n8n
CMD ["n8n", "start"]