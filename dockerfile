FROM php:7.4.30-apache
RUN apt-get update && apt-get install -y \
	vim \
	git \
	curl \
	zip \
	unzip \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql 

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
	php composer-setup.php --install-dir=/bin --filename=composer; \
	php -r "unlink('composer-setup.php');"; \
	a2enmod rewrite; \
	curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash; \
	source ~/.bashrc; \
	nvm install v16.16.0; \
	apt-get install -y npm; \