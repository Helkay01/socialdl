FROM php:8.2-apache

# Install Python 3
RUN apt-get update && apt-get install -y python3

# Copy files to web root
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Enable Apache mod_rewrite if needed (optional)
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80
