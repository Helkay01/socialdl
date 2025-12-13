FROM php:8.2-apache

# -----------------------------------------------------
# Enable required Apache modules
# -----------------------------------------------------
RUN a2enmod rewrite headers

# -----------------------------------------------------
# Install system dependencies
# -----------------------------------------------------
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    ca-certificates \
    curl \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------
# Install yt-dlp (Python)
# -----------------------------------------------------
RUN pip3 install --no-cache-dir yt-dlp

# -----------------------------------------------------
# Copy application files
# -----------------------------------------------------
WORKDIR /var/www/html

COPY extract.py /var/www/html/extract.py
COPY index.php /var/www/html/index.php

# -----------------------------------------------------
# Permissions (IMPORTANT)
# -----------------------------------------------------
RUN chmod +x /var/www/html/extract.py \
    && chown -R www-data:www-data /var/www/html

# -----------------------------------------------------
# PHP configuration (enable shell execution)
# -----------------------------------------------------
RUN echo "disable_functions =" > /usr/local/etc/php/conf.d/exec.ini

# -----------------------------------------------------
# Health / version check
# -----------------------------------------------------
RUN python3 --version \
    && pip3 --version \
    && yt-dlp --version \
    && php -v

EXPOSE 80
