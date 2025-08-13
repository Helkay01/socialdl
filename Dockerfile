FROM php:8.2-apache

RUN apt-get update && apt-get install -y python3 python3-pip

RUN python3 --version && pip3 --version
