FROM phusion/passenger-ruby22

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production
ENV SIDEKIQ_CONCURRENCY 5

# Use baseimage-docker's init system which will start nginx
CMD ["/sbin/my_init"]

# Ensure nginx runs && remove default site
RUN rm -f /etc/service/nginx/down && rm /etc/nginx/sites-enabled/default

ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD gzip_max.conf /etc/nginx/conf.d/gzip_max.conf
ADD install-wkhtmltopdf.sh /sbin/install-wkhtmltopdf.sh

# Install wkhtmltopdf
RUN apt-get update && \
    apt-get install -y \
    libqtwebkit-dev \
    qt4-qmake && \
    /sbin/install-wkhtmltopdf.sh

# Clean up unneeded files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Some gems log to log dir
RUN mkdir -p /home/app/webapp/log
