# Port testing Addon
Very simple go webserver that executes a HTTP GET against a
provided endpoint and tests for an expected returned status code

This application doesn't do any testing itself, it will only execute
what you want it to. An expect use is to config a dashboard like grafana
to, on a schedule, hit an endpoint and check the response. Populate the
influx with the result and display the data on the dashboard.