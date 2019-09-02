FROM python:3.7.4-buster
LABEL maintainer="Arne Schubert<atd.schubert@gmail.com>"
LABEL maintainer="Juan Méndez<juan@gkudos.com>"

ENV MAPPROXY_PROCESSES 4
ENV MAPPROXY_THREADS 2

RUN set -x \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    python-yaml \
    libgeos-dev \
    python-lxml \
    libgdal-dev \
    build-essential \
    python-dev \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    python-virtualenv \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -ms /bin/bash mapproxy \
  && mkdir -p /mapproxy \
  && chown mapproxy /mapproxy \
  && pip install --upgrade pip \
  && pip install Shapely Pillow requests geojson uwsgi git+https://github.com/mapproxy/mapproxy.git@1.12.0  \
  && mkdir -p /docker-entrypoint-initmapproxy.d

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh 
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mapproxy"]

USER mapproxy
VOLUME ["/mapproxy"]
EXPOSE 8080
# Stats
EXPOSE 9191



