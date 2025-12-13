FROM php:8.2-apache

# Enable Apache modules
RUN a2enmod rewrite headers

WORKDIR /var/www/html
COPY index.php /var/www/html/index.php

EXPOSE 80
CMD ["apache2-foreground"]
