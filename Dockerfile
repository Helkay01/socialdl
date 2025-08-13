FROM php:8.2-apache

RUN apt-get update && apt-get install -y python3 python3-pip python3-venv python3-dev

RUN python3 --version && pip3 --version

RUN python3 -m pip install yt-dlp --no-cache-dir

COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

RUN a2enmod rewrite

EXPOSE 80
