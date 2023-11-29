FROM mapasculturais/mapasculturais:v6.0.0




RUN git clone https://github.com/mapasculturais/plugin-multipleLocalAuth /var/www/html/protected/application/plugins/MultipleLocalAuth


COPY compose/common/config.php /var/www/html/protected/application/conf/config.php
COPY compose/common/config.d /var/www/html/protected/application/conf/conf-common.d
COPY compose/production/config.d /var/www/html/protected/application/conf/config.d

COPY themes /var/www/html/protected/application/themes
COPY plugins /var/www/html/protected/application/plugins





