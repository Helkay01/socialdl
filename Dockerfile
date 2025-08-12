FROM php:8.2-apache

# 1. Install Python and additional dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    ffmpeg \
    build-essential \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# 2. Upgrade pip to latest version
RUN python3 -m pip install --upgrade pip

# 3. Install yt-dlp
RUN pip3 install yt-dlp --no-cache-dir

# 4. Copy project files
COPY . /var/www/html/
WORKDIR /var/www/html

# 5. Enable Apache rewrite if needed
RUN a2enmod rewrite

EXPOSE 80
