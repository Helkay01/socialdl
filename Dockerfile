FROM php:8.2-apache
COPY index.php /var/www/html/


RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip install yt-dlp

RUN python3 --version && pip3 --version
