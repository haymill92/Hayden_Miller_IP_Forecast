# Hayden_Miller_IP_Forecast

The `ip_forecast.sh` script file and `Dockerfile` are both in the repo. the below docker commands require you to clone the repo and run the commands in the local directory of the cloned repo.

In the `ip_forecast.sh` file I was originally trying to parse the `dt` json object of the daily forecast. However the `dt` object returned as a blankspace separated listed instead of a new line separated list like the weather description. I attempted to parse this the same manner with `IFS=' '`, however when I did this it returned the list into the first object of the array as a newline separated list, and the rest of the array was blank. I attemped to reparse the new newline separated array object with `IFS=$'\n'` however, it kept returning the same newline separated list. I swapped to a method of using today's date +n days for the future forecast with the `date` command, but this would prefferably parse the `dt` object to clean up the forecast.

The `Dockerfile` uses `ENTRYPOINT` to execute the shell script when the container is run.

## Building the Docker Container

In order to build the docker container and tag it as ip_forecast:1.0 run the below command.

```docker build -t ip_forecast:1.0 ./```

## Running the Container

To Run the container and output the Weather Forecast run the below command. If you run without the IP address, it will return your local weather.

```sudo docker run ip_forecast 1.1.1.1```

To ensure you are using the `1.0` tag instead of the `latest` run `sudo docker run ip_forecast:1.0` instead.
