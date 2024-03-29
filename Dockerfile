FROM elixir:1.3

# WARNING: This expects there to be a release in the rel directory

MAINTAINER Nikko Miu <nikkoamiu@gmail.com>

# Install NGINX
RUN wget https://gist.githubusercontent.com/nikkomiu/cd15d615fc3390ebbd79e9d078458d10/raw/nginx_install.sh
RUN chmod +x ./nginx_install.sh
RUN ./nginx_install.sh 1.11.2

# Move NGINX config into place
COPY deploy/nginx.conf /etc/nginx/nginx.conf

# Build ENV
ENV APP_VER=0.0.1

# Copy release
COPY rel/chat_up/releases/$APP_VER/chat_up.tar.gz /usr/chat_up/app.tar.gz
WORKDIR /usr/chat_up

# Extract release
RUN tar -xvf app.tar.gz
RUN chmod +x bin/chat_up

# Copy start script
COPY deploy/run.sh /usr/chat_up/bin
RUN chmod +x bin/run.sh

# Runtime ENV
ENV MIX_ENV=prod
ENV SECRET_KEY_BASE=xeqWUJ03Yx7JQ+if21rLBKIZ6cZKMyp3hcJYuC3U0NDQKe1APerQ3F5rD/E3s+e1
ENV DB_HOST=192.168.99.100
ENV DB_BASE=chat_up_prod
ENV DB_USER=chat_up_svc
ENV DB_PASS=chatuppassword

# Expose NGINX port
EXPOSE 80

# Run startup script
CMD ["bin/run.sh"]
