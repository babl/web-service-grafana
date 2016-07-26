FROM grafana/grafana:3.0.4
ADD grafana_ini/grafana.ini /etc/grafana/
ADD grafana_db/grafana.db /var/lib/grafana/
COPY public /usr/share/grafana/public
CMD ["GF_SERVER_HTTP_PORT=$PORT /run.sh"]
