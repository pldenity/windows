#!/bin/bash

# Przerwij działanie skryptu w przypadku błędu
set -e

#echo "=== 1. Tworzenie i przechodzenie do katalogu ==="
#mkdir -p /home/igor/Pulpit/docker/
#cd /home/igor/Pulpit/docker/

echo "=== 3. Uruchamianie kontenera w tle ==="
docker compose up -d

echo "=== 4. Otwieranie instalacji w Google Chrome Unstable ==="
# Czekamy 3 sekundy na zainicjowanie portu przez Dockera
sleep 3
/opt/google/chrome-unstable/google-chrome-unstable "http://localhost:8006/" > /dev/null 2>&1 & disown

echo "Skrypt wykonał się pomyślnie. Instalacja Tiny11 trwa w oknie przeglądarki!"
