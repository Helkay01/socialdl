FROM php:8.2-apache

# Install Python and build dependencies (without python3-pip)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    curl \
    ffmpeg \
    build-essential \
    ca-certificates \
    libssl-dev \
    libffi-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install pip manually via get-pip.py
RUN curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
 && python3 get-pip.py --force-reinstall \
 && rm get-pip.py

# Install yt-dlp with no cache
RUN python3 -m pip install yt-dlp --no-cache-dir

# Copy project files and set permissions
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Enable Apache rewrite module
RUN a2enmod rewrite

EXPOSE 80
