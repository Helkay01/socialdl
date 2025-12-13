FROM php:8.2-apache

# -----------------------------------------------------
# Enable Apache modules
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
    git \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------
# Install yt-dlp for Python
# -----------------------------------------------------
RUN pip3 install --no-cache-dir yt-dlp

# -----------------------------------------------------
# Set working directory and copy files
# -----------------------------------------------------
WORKDIR /var/www/html
COPY index.php /var/www/html/index.php
COPY extract.py /var/www/html/extract.py

# -----------------------------------------------------
# Permissions
# -----------------------------------------------------
RUN chmod +x /var/www/html/extract.py \
    && chown -R www-data:www-data /var/www/html

# -----------------------------------------------------
# Enable shell_exec (if still needed)
# -----------------------------------------------------
RUN echo "disable_functions =" > /usr/local/etc/php/conf.d/exec.ini

# -----------------------------------------------------
# Expose Apache port
# -----------------------------------------------------
EXPOSE 80

# -----------------------------------------------------
# Start both Apache and Python service
# -----------------------------------------------------
# Use a simple shell to launch both services
CMD [ "bash", "-c", "\
    python3 /var/www/html/extract.py & \
    apache2-foreground \
"]
