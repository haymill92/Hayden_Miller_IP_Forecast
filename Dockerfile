FROM debian:buster-slim

RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends curl jq 
COPY ./ip_forecast.sh /
RUN chmod +x /ip_forecast.sh
ENTRYPOINT ["/ip_forecast.sh"]
