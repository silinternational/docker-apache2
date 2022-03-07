FROM silintl/ubuntu:21.04
MAINTAINER "Phillip Shipley" <phillip_shipley@sil.org>

ENV REFRESHED_AT 2019-09-06
ENV HTTPD_PREFIX /etc/apache2

# Install apache2
RUN apt-get update -y \
	&& apt-get install -y \
		apache2

# Remove default site, configs, and mods not needed
WORKDIR $HTTPD_PREFIX
RUN a2dissite 000-default \
    && a2disconf serve-cgi-bin.conf \
    && a2enmod expires \
    && a2enmod headers \
    && a2enmod rewrite \
    && a2dismod -f autoindex \
    && service apache2 restart

# Overwrite default security.conf file
#COPY security.conf $HTTPD_PREFIX/conf-available/security.conf

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
