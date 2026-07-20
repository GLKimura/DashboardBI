#!/bin/bash
set -e

# Gera a chave da aplicação se ainda não existir uma (necessário no primeiro deploy)
if [ -z "$APP_KEY" ]; then
    php artisan key:generate --force
fi

# Cacheia configurações para produção (melhora performance)
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Roda as migrations pendentes automaticamente a cada deploy
php artisan migrate --force

# Sobe o Apache em primeiro plano
exec apache2-foreground