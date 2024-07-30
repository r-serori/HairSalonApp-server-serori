# バックエンド用の設定
FROM php:8.2-apache 

# バックエンドアプリケーション用の作業ディレクトリを作成
WORKDIR /var/www/html

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
  git \
  zip \
  unzip \
  && rm -rf /var/lib/apt/lists/*

# Composer のインストール
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Composer の依存関係をインストールするために composer.json と composer.lock を先にコピー
COPY composer.json composer.lock ./
RUN composer install --no-interaction

# バックエンドのコードをコピー
COPY . ./

# Apache を起動するコマンド
CMD ["apache2-foreground"]
