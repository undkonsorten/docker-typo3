FROM php:5.6-apache
MAINTAINER Martin Helmich <typo3@martin-helmich.de>

ENV TYPO3_VERSION 6.2
# Install TYPO3
RUN apt-get update &&\
    apt-get install -y wget

# Configure PHP
RUN apt-get install -y \
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        rsync \
        zlib1g-dev \
        python3 \
        unzip \
        python3-setuptools

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) mysqli soap gd zip
RUN echo 'always_populate_raw_post_data = -1\nmax_execution_time = 240\nmax_input_vars = 1500\nupload_max_filesize = 32M\npost_max_size = 32M' > /usr/local/etc/php/conf.d/typo3.ini

# Install required 3rd party tools
RUN apt-get install -y graphicsmagick

RUN mkdir /typo3 &&\
	cd /typo3 &&\
	wget -O - https://get.typo3.org/$TYPO3_VERSION | tar -xzf -


# Configure Apache as needed
RUN a2enmod rewrite

# Configure volumes
VOLUME /var/www/html

ADD install_typo3.sh /install_typo3.sh
RUN chmod 755 /install_typo3.sh

CMD /install_typo3.sh $TYPO3_VERSION