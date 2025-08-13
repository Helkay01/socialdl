FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-venv \
    python3-setuptools \
    python3-pip \
    curl \
    wget \
    ca-certificates \
    ffmpeg \
    build-essential \
    libssl-dev \
    libffi-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Confirm Python and pip versions
RUN python3 --version && pip3 --version


# Install yt-dlp
RUN python3 -m pip install yt-dlp --no-cache-dir

# Copy app files
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Enable Apache rewrite module
RUN a2enmod rewrite

EXPOSE 80
