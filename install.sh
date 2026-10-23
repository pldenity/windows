#!/bin/bash

# Przerwij działanie skryptu w przypadku błędu
set -e

echo "=== 1. Tworzenie i przechodzenie do katalogu ==="
mkdir -p /home/igor/Pulpit/docker/
cd /home/igor/Pulpit/docker/

echo "=== 2. Tworzenie konfiguracji docker-compose.yml dla Tiny11 ==="
# Zamiast błędnego git clone, tworzymy plik konfiguracyjny bezpośrednio na dysku
cat << 'EOF' > docker-compose.yml
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "tiny11"
      LANGUAGE: "Polish"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    volumes:
      - ./windows:/storage
    restart: always
    stop_grace_period: 2m
EOF

echo "=== 3. Uruchamianie kontenera w tle ==="
docker compose up -d

echo "=== 4. Otwieranie instalacji w Google Chrome Unstable ==="
# Czekamy 3 sekundy na zainicjowanie portu przez Dockera
sleep 3
/opt/google/chrome-unstable/google-chrome-unstable "http://localhost:8006/" > /dev/null 2>&1 & disown

echo "Skrypt wykonał się pomyślnie. Instalacja Tiny11 trwa w oknie przeglądarki!"
