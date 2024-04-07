// Build:
docker build -t moja_aplikacja:latest --build-arg VERSION=4.0.0 --build-arg SERVER_IP=$(hostname -I | cut -d' ' -f1) --build-arg SERVER_NAME=$(hostname) .

// Run:
docker run -d -p 8080:80 moja_aplikacja:latest

// Wynik (sprawdzenie curlem):
curl http://localhost:8080 


# Maksym Shepeta