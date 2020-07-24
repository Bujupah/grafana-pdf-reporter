# Grafana Reporter
Generate faster PDF reports from grafana with a lightweight http server made with dart lang.
![Alt Text](https://raw.githubusercontent.com/Bujupah/grafana-pdf-reporter/master/demo/demo.gif)


## Requirements
Runtime requirements: 
- `Nothing is required`.

Build requirements:
- [Dart](https://dart.dev/)
- [Aqueduct](https://aqueduct.io/)

## Build and run
Get source files

    git clone https://github.com/Bujupah/grafana-pdf-reporter
Build and install `reporter`
    
    pub get
    aqueduct build
Running without any flags assumes Grafana is reachable at localhost:8888:

    reporter

Query available flags.


``` 
reporter --help

-a, --address                 The address to listen on. See HttpServer.bind for more details. Using the default will listen on any address. \
-c, --config-path             The path to a configuration file. This File is available in the ApplicationOptionsfor a ApplicationChannel to use to read application-specific configuration values. Relative paths are relative to [directory].
                              (defaults to "config.yaml")
-n, --isolates                Number of isolates handling requests.
-p, --port                    The port number to listen for HTTP requests on.
                              (defaults to "8888")
    --ipv6-only               Limits listening to IPv6 connections only.
    --ssl-certificate-path    The path to an SSL certicate file. If provided along with --ssl-certificate-path, the application will be HTTPS-enabled.
    --ssl-key-path            The path to an SSL private key file. If provided along with --ssl-certificate-path, the application will be HTTPS-enabled.
    --timeout                 Number of seconds to wait to ensure startup succeeded.
                              (defaults to "45")
```

## EndPoints

```GET :``` `http://IP:PORT/api/generate/report/{UID}` \
UID = Dashboard uid 

```QUERY PARAMS : ``` \
theme = light | dark \
from = now-5h (grafana period params) \
to = now (grafana period params) \
token = Grafana Token

Example: \
```http://IP:PORT/api/generate/report/nhvpcX7Gz?theme=light&from=now-5h&to=now&token=TOKENAPI```


## Docker
* TODO


## TODO
* Schedule reports
* Grafana Variables


## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).
