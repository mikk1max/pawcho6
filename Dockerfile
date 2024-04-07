# Etap pierwszy: Budowanie aplikacji Node.js
FROM scratch AS myalpine
ADD alpine-minirootfs-3.19.1-aarch64.tar /

# Etap pierwszy: Budowanie aplikacji Node.js
FROM myalpine AS builder

# Ustawienie zmiennej środowiskowej na wersję aplikacji
ARG VERSION=1.0.0

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

# Instalacja Node.js
RUN apk update && apk add nodejs npm

# Katalog roboczy w kontenerze
WORKDIR /usr/app

# Skopiowanie plików aplikacji do kontenera
COPY ./package.json ./

# Instalacja zależności
RUN npm install

COPY ./index.js ./

EXPOSE 8080

# Dodanie polecenia do uruchomienia aplikacji Node.js
CMD ["node", "index.js"]

# Etap drugi: Budowanie obrazu Nginx
FROM nginx:latest

# Kopiowanie plików aplikacji z etapu pierwszego do serwera HTTP
COPY --from=builder /usr/app /usr/share/nginx/html

# Ustawienie adresu IP serwera
ARG SERVER_IP
RUN echo "Adres IP serwera: $(hostname -I | awk '{print $1}')" > /usr/share/nginx/html/index.html

# Ustawienie nazwy serwera
ARG SERVER_NAME
RUN echo "Nazwa serwera: $SERVER_NAME" >> /usr/share/nginx/html/index.html

# Ustawienie wersji aplikacji
ARG VERSION
RUN echo "Wersja aplikacji: $VERSION" >> /usr/share/nginx/html/index.html

# Dodanie HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:8080/ || exit 1
