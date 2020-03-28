FROM fedora:31

ENV THREADS 5

EXPOSE 15000
VOLUME /opt/wesnoth

RUN dnf -y install curl wesnoth wesnoth-data wesnoth-tools wesnoth-server && dnf clean all

RUN curl -L https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
  | tar --directory /usr/sbin -xvz


COPY /src /opt/wesnoth

CMD /usr/sbin/dockerize -template /opt/wesnoth/wesnothd.cfg.tmpl:/opt/wesnoth/wesnothd.cfg \
    /usr/sbin/wesnothd -c /opt/wesnoth/wesnothd.cfg --threads $THREADS
