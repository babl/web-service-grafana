FROM grafana/grafana:3.1.1
ADD grafana_ini/grafana.ini /etc/grafana/
ADD grafana_db/grafana.db /var/lib/grafana/
# COPY public /usr/share/grafana/public # NO SOURCE CHANGED YET
CMD ["GF_SERVER_HTTP_PORT=$PORT /run.sh"]
