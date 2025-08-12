FROM php:8.2-apache

# Install system packages: Python 3 and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Install yt-dlp using pip
RUN pip3 install yt-dlp

# Copy project files into the container
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Enable Apache rewrite module if needed
RUN a2enmod rewrite

# Expose port
EXPOSE 80
