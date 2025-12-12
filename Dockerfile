FROM php:8.2-apache

COPY index.php /var/www/html/

# Install Python + pip + ffmpeg + SSL certs
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    ca-certificates \
    && update-ca-certificates

# Install yt-dlp properly
RUN python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m pip install yt-dlp

# Debug versions
RUN python3 --version && pip3 --version && yt-dlp --version

