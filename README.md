# Mapproxy for Docker

MapProxy docker image from the [YAGA Development-Team](https://yagajs.org)

- [Mapproxy for Docker](#mapproxy-for-docker)
  - [Supported tags](#supported-tags)
  - [What is MapProxy](#what-is-mapproxy)
  - [Build container](#build-container)
  - [Run container](#run-container)
    - [Environment variables](#environment-variables)
  - [Enhance the image](#enhance-the-image)
  - [Contributing](#contributing)
  - [License](#license)

## Supported tags

* `1.12.0a`, `1.12.0`, `latest`

## What is MapProxy

[MapProxy](https://mapproxy.org/) is an open source proxy for geospatial data. It caches, accelerates and transforms
data from existing map services and serves any desktop or web GIS client.

## Build container

```bash
docker build -t igac/mapproxy .
docker images igac/mapproxy
docker tag xxxxx igac/mapproxy:1.12.0
docker push igac/mapproxy:1.12.0
```

## Run container

You can run the container with a command like this:

```bash
docker run -v /path/to/mapproxy:/mapproxy -p 8080:8080 igac/mapproxy:1.12.0a
```

*It is optional, but recommended to add a volume. Within the volume mapproxy get the configuration, or create one
automatically. Cached tiles will be stored also into this volume.*

The container normally runs in [http-socket-mode](http://uwsgi-docs.readthedocs.io/en/latest/HTTP.html). If you will not
run the image behind a HTTP-Proxy, like [Nginx](http://nginx.org/), you can run it in direct http-mode by running:

```bash
docker run -v /path/to/mapproxy:/mapproxy -p 8080:8080 igac/mapproxy:1.12.0a mapproxy http
```

### Environment variables

* `MAPPROXY_PROCESSES` default: 4
* `MAPPROXY_THREADS` default: 2

## Enhance the image

You can put a `mapproxy.yaml` into the `/docker-entrypoint-initmapproxy.d` folder on the image. On startup this will be
used as MapProxy configuration. Attention, this will override an existing configuration in the volume!

Additional you can put shell-scripts, with `.sh`-suffix in that folder. They get executed on container startup.

You should use the `mapproxy` user within the container, especially not `root`!

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull
requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a
[GitHub issue](https://github.com/yagajs/docker-mapproxy/issues), especially for more ambitious contributions.
This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help
you find out if someone else is working on the same thing.

## License

This project is published under [ISC License](LICENSE).
