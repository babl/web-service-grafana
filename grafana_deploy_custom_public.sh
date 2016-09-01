#!/bin/sh

npm install --prefix $GOPATH/src/github.com/grafana/grafana/
npm run build --prefix $GOPATH/src/github.com/grafana/grafana/

rm -rf ./public
cp -R $GOPATH/src/github.com/grafana/grafana/public_gen ./public