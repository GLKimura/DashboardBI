FROM php:8.2-apache

# Instala dependências do sistema e extensões PHP necessárias
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    libsqlite3-dev \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install \
        pdo \
        pdo_pgsql \
        pdo_sqlite \
        pgsql \
        mbstring \
        zip \
        exif \
        pcntl \
        gd \
        xml \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Habilita mod_rewrite (necessário para as rotas do Laravel)
RUN a2enmod rewrite

# Aponta o Apache para a pasta public/ do Laravel
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf

# Permite que o .htaccess do Laravel funcione (necessário para as rotas
# amigáveis; sem isso o Apache devolve 404 para tudo que não for arquivo real)
RUN { \
        echo '<Directory ${APACHE_DOCUMENT_ROOT}>'; \
        echo '    Options Indexes FollowSymLinks'; \
        echo '    AllowOverride All'; \
        echo '    Require all granted'; \
        echo '</Directory>'; \
    } >> /etc/apache2/apache2.conf

# Instala o Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instala Node.js (para o build do Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

WORKDIR /var/www/html

# Copia os arquivos do projeto
COPY . .

# Instala dependências PHP (sem pacotes de desenvolvimento, para produção)
RUN composer install --no-dev --optimize-autoloader

# Instala dependências JS e builda os assets (Vite)
RUN npm install && npm run build

# Garante que o arquivo SQLite exista e tenha permissão de escrita.
RUN mkdir -p database && touch database/database.sqlite

# Ajusta permissões das pastas/arquivos que o Laravel precisa escrever
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database \
    && chmod 664 /var/www/html/database/database.sqlite

EXPOSE 80

# Script de entrada: roda migrations, cacheia config e sobe o Apache
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]