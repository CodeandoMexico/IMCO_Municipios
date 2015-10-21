FROM phusion/passenger-ruby22:latest
MAINTAINER "Mikesaurio <mikesaurio@civica.digital>"

ENV HOME /root

CMD ["/sbin/my_init"]
RUN ruby-switch --set ruby2.2

USER app
WORKDIR /home/app/minegocio

ADD . /home/app/minegocio
ADD docker/minegocio.conf /etc/nginx/sites-enabled/
ADD docker/00_app_env.conf /etc/nginx/conf.d/
ADD docker/minegocio-env.conf /etc/nginx/main.d/
ADD docker/database.yml /home/app/minegocio/config/database.yml

VOLUME ["/home/app/minegocio/lib/temp"]

USER root
RUN bundle install
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
RUN chown -R app:app /home/app/minegocio /home/app/minegocio/lib/tem
RUN ln -sf /proc/self/fd /dev/

RUN whenever --update-crontab && crontab -l

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp