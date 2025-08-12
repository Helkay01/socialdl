FROM php:8.2-apache

# 1. Install Python and dependencies including libssl-dev and libffi-dev
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    ffmpeg \
    build-essential \
    ca-certificates \
    libssl-dev \
    libffi-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# 2. Upgrade pip without cache to avoid issues
RUN python3 -m pip install --upgrade pip --no-cache-dir

# 3. Install yt-dlp with no cache
RUN python3 -m pip install yt-dlp --no-cache-dir

# 4. Copy your project files and set ownership to Apache user
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

# 5. Set working directory
WORKDIR /var/www/html

# 6. Enable Apache rewrite module
RUN a2enmod rewrite

# 7. Expose HTTP port
EXPOSE 80
