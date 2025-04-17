FROM node:18-slim AS scraper

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    fonts-liberation \
    libappindicator3-1 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-glib-1-2 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Set environment variable to skip Puppeteer's bundled Chromium download
# Stage 1: Scraper
FROM node:18-slim AS scraper-stage
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
WORKDIR /app
COPY scraper/package.json .
RUN apt-get update && apt-get install -y chromium && rm -rf /var/lib/apt/lists/*
RUN npm install
COPY scraper/scrape.js .
# Create and populate the /output directory
RUN mkdir -p /output && echo "Placeholder content" > /output/example.txt
VOLUME /output

# Stage 2: Server
FROM python:3.9-slim AS server
WORKDIR /app
COPY server/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY server/server.py .
COPY --from=scraper-stage /output /output
EXPOSE 5000
CMD ["python", "server.py"]
