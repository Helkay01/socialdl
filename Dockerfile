FROM php:8.2-apache

COPY index.php /var/www/html/

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    ca-certificates \
    && update-ca-certificates

# Install yt-dlp using Debian Bookworm's required flag
RUN pip3 install --break-system-packages yt-dlp

RUN python3 --version && pip3 --version && yt-dlp --version
