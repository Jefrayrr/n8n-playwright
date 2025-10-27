# Imagen base oficial de n8n
FROM docker.n8n.io/n8nio/n8n:latest

# Cambiamos a usuario root para instalar dependencias
USER root

# Instalar Playwright y los navegadores (solo Chromium para ahorrar espacio)
RUN npm install -g playwright && \
    npx playwright install --with-deps chromium

# Crear carpeta para scripts personalizados
RUN mkdir -p /data/scripts
WORKDIR /data

# Copiar scripts al contenedor
COPY scripts/ /data/scripts/

# Volvemos al usuario por defecto de n8n
USER node

# Exponemos el puerto 5678
EXPOSE 5678

# Iniciar n8n
CMD ["n8n", "start"]