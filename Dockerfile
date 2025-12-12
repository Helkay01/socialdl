FROM php:8.2-apache

# Copy your php file(s)
COPY index.php /var/www/html/

# Install system dependencies (Python + ffmpeg)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    unzip \
    git \
    ca-certificates \
    && update-ca-certificates

# Install yt-dlp using Bookworm override
RUN pip3 install --break-system-packages yt-dlp

# -----------------------------------------------------
# Install Composer
# -----------------------------------------------------
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php

# -----------------------------------------------------
# Install PHP yt-dlp wrapper
# -----------------------------------------------------
WORKDIR /var/www/html
RUN composer require norkunas/youtube-dl-php

# Show versions
RUN python3 --version && pip3 --version && yt-dlp --version
