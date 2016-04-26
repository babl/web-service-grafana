FROM grafana/grafana
ADD grafana_ini/grafana.ini /etc/grafana/
ADD grafana_db/grafana.db /var/lib/grafana/
CMD ["GF_SERVER_HTTP_PORT=$PORT /run.sh"]
