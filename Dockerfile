FROM php:8.2-apache

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Install yt-dlp
RUN pip3 install yt-dlp

# Copy app files
COPY . /var/www/html/

WORKDIR /var/www/html

# Enable Apache mod_rewrite (optional)
RUN a2enmod rewrite

EXPOSE 80

