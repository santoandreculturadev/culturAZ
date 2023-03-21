FROM mapasculturais/mapasculturais:v5.5




RUN git clone https://github.com/mapasculturais/plugin-multipleLocalAuth /var/www/html/protected/application/plugins/MultipleLocalAuth

ENV TZ=America/Sao_Paulo

COPY compose/common/config.php /var/www/html/protected/application/conf/config.php
COPY compose/common/config.d /var/www/html/protected/application/conf/conf-common.d
COPY compose/production/config.d /var/www/html/protected/application/conf/config.d

COPY themes /var/www/html/protected/application/themes
COPY plugins /var/www/html/protected/application/plugins

