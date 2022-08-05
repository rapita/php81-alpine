# Docker PHP 8.1 Alpine

This docker image with PHP 8.1 based on Alpine Linux. This image contains extensions needed for own projects (amqp, grpc, mysql, pgsql, redis, rdkafka).

Requirements for container based on this image:
* The container must be tight and do only one job. For example, run web server by roadrunner, run consuming queue or message broker.
* Inside a container, you shouldn't want to run multiple processes like supervisor, cron, etc.
* The application configuration must be done through the [Docker Environment Variable](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file) or the [sidecar container pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/sidecar).
* To apply application configuration changes in a container you must start a new container (with new configurations) and stop the old container (with old configurations).
* Logging inside the container must be output to stderr and stdout.

## Customization

The PHP ini file is located at /usr/local/etc/php/conf.d/ directory.
You can customize the PHP ini file by adding your own ini file to the directory.

## Xdebug

For enable xdebug  in local development you need to create in your project directory `xdebug.ini` file with content:
```ini
zend_extension=xdebug

[xdebug]
xdebug.mode=develop,debug
xdebug.client_host=host.docker.internal
xdebug.start_with_request=yes
xdebug.log=/tmp/xdebug.log
```

Then, in the php service definition in docker-compose.yml, add the following to the volumes element.
```yaml
- ./xdebug.ini:/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
```
