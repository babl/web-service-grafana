FROM grafana/grafana
ADD grafana_ini/grafana.ini /etc/grafana/
ADD grafana_db/grafana.db /var/lib/grafana/
CMD ["/run.sh"]