# Pobieranie obrazu PHP w wersji 8.1 z oficjalnego repozytorium Docker Hub
FROM php:8.1-fpm

# Instalacja zależności wymaganych do uruchomienia Symfony
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    unzip

# Instalacja i konfiguracja rozszerzeń PHP
RUN docker-php-ext-install pdo pdo_mysql zip

# Instalacja narzędzia Composer (managera pakietów PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Ustawienie katalogu roboczego na katalog /var/www
WORKDIR /var/www

# Skopiowanie plików projektu Symfony do katalogu roboczego w obrazie Dockera
COPY . .

# Uruchomienie komendy 'composer install', aby zainstalować zależności projektu Symfony
RUN composer install

# Expose na domyślny port, na którym działa PHP-FPM
EXPOSE 9000

# Uruchomienie serwera PHP-FPM
CMD ["php-fpm"]

