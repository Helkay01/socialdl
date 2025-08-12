FROM php:8.2-apache

# Install Python and dependencies (including setuptools and venv), plus other tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-venv \
    python3-setuptools \
    curl \
    ffmpeg \
    build-essential \
    ca-certificates \
    libssl-dev \
    libffi-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Upgrade pip using get-pip.py script (force reinstall)
RUN curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
 && python3 get-pip.py --force-reinstall \
 && rm get-pip.py

# Install yt-dlp with no cache
RUN python3 -m pip install --no-cache-dir yt-dlp

# Copy project files and set permissions
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Enable Apache rewrite module
RUN a2enmod rewrite

EXPOSE 80
