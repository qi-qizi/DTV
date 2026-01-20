#!/bin/bash
# Windows Build Script for DTV
# Requires: Docker

set -e

echo "🏗️  Building DTV Windows installer..."

docker buildx build \
  --platform windows/amd64 \
  --tag dtv-windows-builder \
  -f - . << 'EOF'
FROM ghcr.io/tauri-apps/tauri-build:latest
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build
RUN cargo tauri build
EOF

echo "✅ Build complete! Check Docker output for .msi/.exe files."
