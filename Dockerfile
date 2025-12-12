FROM php:8.2-apache

COPY index.php /var/www/html/

# Install Python + pip + dependencies for yt-dlp
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    ffmpeg \
    build-essential \
    libffi-dev \
    libssl-dev \
    ca-certificates \
    && update-ca-certificates

# Fix Debian pip issues by disabling pip’s "externally-managed" restriction
RUN echo "[global]\nbreak-system-packages = true" > /etc/pip.conf

# Now pip upgrade works safely
RUN python3 -m pip install --upgrade pip wheel setuptools

# Install yt-dlp
RUN python3 -m pip install yt-dlp

# Show versions to ensure success
RUN python3 --version && pip3 --version && yt-dlp --version
