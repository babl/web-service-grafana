<h3>Babl/Grafana WebModule: Update dashboards/graphs/configurations</h3>
---------

This document explains on how to update the current web-module <b>babl/grafana</b> internal configuration and database data. Module information/web-content can be found here:

* [https://babl.sh/babl/grafana](https://babl.sh/babl/grafana)
* [https://grafana.babl.bablusercontent.com/](https://grafana.babl.bablusercontent.com/)

Grafana current setup requires to embed 2 files into the docker container babl web-module, <b>'/etc/grafana/grafana.ini'</b> for the service configuration settings and an sqlite database file <b>'/var/lib/grafana/grafana.db'</b> to store all the dasboard, graphs, users credentials, api tokens, application configuration data.

<h4>Grafana.ini</h4>
Changing the service configuration data can be done in 2 different ways:

1. by updating the repository file, re-building docker container and re-publish the module:


		> git clone git@git.babl.sh:babl/grafana babl_grafana
		> cd babl_grafana
		# edit the grafana.ini file and save changes
		> nano grafana_ini/grafana.ini
		> git add .
		> git commit -m "Updating grafana.ini default service settings"
		> babl-build build
		> git push origin master
		# new module will be automatically re-published


2. by overriding the values by using environment variables: [http://docs.grafana.org/installation/configuration/](http://docs.grafana.org/installation/configuration/)

		export GF_SERVER_HTTP_PORT=8080

	For example, grafana service is set to run on a default port 3000 (can be adjusted to other value in the grafana.ini file, server.http_port=8080), but for babl current setup this value requires to be adjusted externally via $PORT env. variable. This would also require to re-publish the new docker container with the required changes:

		> git clone git@git.babl.sh:babl/grafana babl_grafana
		> cd babl_grafana
		# edit the Dockerfile file, add the following command and save changes:
		## CMD ["GF_SERVER_HTTP_PORT=$PORT /run.sh"]
		> nano Dockerfile
		> git add .
		> git commit -m "Updating Dockerfile: set env. var GF_SERVER_HTTP_PORT with $PORT value"
		> babl-build build
		> git push origin master
		# new module will be automatically re-published


<h4>Grafana.db</h4>

Updating the sqlite database will require additional work, a local grafana instance should be running (and pointing to this respository database) so that all new configurations are reflected on that database. Once the babl/grafana docker container is re-build it will include that database and all the new configurations.


1. Clone the babl/grafana module

		> cd ~
		> git clone git@git.babl.sh:babl/grafana babl_grafana
		# Enter the [BABL_GRAFANA_REPO]
		> cd babl_grafana

2. Install grafana locally:
	
	- Linux installation:
	[http://docs.grafana.org/installation/debian/](http://docs.grafana.org/installation/debian/)
	
	- Mac OS X - building from source:
	[http://docs.grafana.org/project/building_from_source/](http://docs.grafana.org/project/building_from_source/)
	
	- Running from a Docker container:
	[http://docs.grafana.org/installation/docker/](http://docs.grafana.org/installation/docker/)
	
		NOTE: The Docker container exposes two volumes, make sure to adjust the volumes to point to the required babl/grafana repository files ([BABL_GRAFANA_REPO]/grafana_db, [BABL_GRAFANA_REPO]/grafana_ini).
	
3. Run grafana with the required babl/grafana database path ([BABL_GRAFANA_REPO]/grafana_db) :

		// Scenario: Mac OS X - building from source
		> cd $GOPATH/src/github.com/grafana/grafana/

		# env. variable to contain the full path of the database ([BABL_GRAFANA_REPO]/grafana_db)
		> export GF_PATHS_DATA=/Users/nelson/babl_grafana/grafana_db

		> ./bin/grafana-server web
	
	Make the new configurations, adjust dashboards, graphs, etc. Exit from './bin/grafana-server'.
	
4. Re-publish the babl/grafana module:

		> cd ~
		# Enter the [BABL_GRAFANA_REPO]
		> cd babl_grafana
		> git add .
		> git commit -m "Updating grafana.db database data"
		> babl-build build
		> git push origin master
		# new module will be automatically re-published

	Confirm that your database updates were depolyed with the re-published module here: [https://grafana.babl.bablusercontent.com/](https://grafana.babl.bablusercontent.com/)