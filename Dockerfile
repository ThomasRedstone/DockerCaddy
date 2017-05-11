FROM thomasredstone/base:2.0.1
MAINTAINER thomas@redstone.me.uk
ENV CACHED_FLAG 1

RUN mkdir -p /var/www /etc/caddy /etc/ssl/caddy && chown -R www-data:www-data /etc/caddy /var/www /etc/ssl/caddy && chmod 700 /etc/ssl/caddy
# Install caddy
RUN apt-get update -qq && apt-get -y upgrade
RUN apt-get install -y wget openssl language-pack-en curl systemd
RUN curl https://getcaddy.com | bash
RUN usermod -u 1000 www-data
VOLUME /var/www/app

# Expose the port 80
EXPOSE 80

ADD Caddyfile /etc/caddy/

# RUN /usr/local/bin/caddy -log stdout -agree=true -conf=/etc/caddy/Caddyfile -root=/var/tmp

# Run Caddy
ENTRYPOINT [ "/usr/local/bin/caddy", "-conf=/etc/caddy/Caddyfile" ]
