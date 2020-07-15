# Port testing Addon
Very simple go webserver that executes an HTTP GET against a
provided endpoint and tests for an expected returned status code

This application doesn't do any testing itself, it will only execute
what you want it to. An expected use is to config a dashboard like grafana
to poll endpoints and check the response.

## Example

```shell script
curl "http://HOST/?endpoint=https://rancher.lqd.dk&expectedStatusCode=200"
```