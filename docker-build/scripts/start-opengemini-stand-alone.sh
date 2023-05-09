#!/bin/bash

mkdir -p $OPENGEMINI_HOME/conf
CONF_FILE=$OPENGEMINI_HOME/conf/opengemini.conf

echo '[common]' > $CONF_FILE
echo '  meta-join = ["127.0.0.1:8092"]' >> $CONF_FILE

echo '[meta]' >> $CONF_FILE
echo '  bind-address = "127.0.0.1:8088"' >> $CONF_FILE
echo '  http-bind-address = "127.0.0.1:8091"' >> $CONF_FILE
echo '  rpc-bind-address = "127.0.0.1:8092"' >> $CONF_FILE

echo -n '  dir = "' >> $CONF_FILE
echo -n "$OPENGEMINI_HOME/meta" >> $CONF_FILE
echo '"' >> $CONF_FILE

echo '[http]' >> $CONF_FILE
echo '  bind-address = "0.0.0.0:8086"' >> $CONF_FILE

echo '[data]' >> $CONF_FILE
echo '  store-ingest-addr = "127.0.0.1:8400"' >> $CONF_FILE
echo '  store-select-addr = "127.0.0.1:8401"' >> $CONF_FILE

echo -n '  store-data-dir = "' >> $CONF_FILE
echo -n "$OPENGEMINI_HOME/data" >> $CONF_FILE
echo '"' >> $CONF_FILE

echo -n '  store-wal-dir = "' >> $CONF_FILE
echo -n "$OPENGEMINI_HOME/data" >> $CONF_FILE
echo '"' >> $CONF_FILE

echo -n '  store-meta-dir = "' >> $CONF_FILE
echo -n "$OPENGEMINI_HOME/meta" >> $CONF_FILE
echo '"' >> $CONF_FILE

echo '[logging]' >> $CONF_FILE

echo -n '  path = "' >> $CONF_FILE
echo -n "$OPENGEMINI_HOME/logs" >> $CONF_FILE
echo '"' >> $CONF_FILE

echo '[gossip]' >> $CONF_FILE
echo '  enabled = false' >> $CONF_FILE

echo '[castor]' >> $CONF_FILE
echo '  enabled = false' >> $CONF_FILE

mkdir -p $OPENGEMINI_HOME/logs
if [ -z "$OPENGEMINI_DELVE_DEBUG" ] || [ $OPENGEMINI_DELVE_DEBUG == "false" ]; then
    nohup ts-server -config $CONF_FILE >>$OPENGEMINI_HOME/logs/opengemini.stdout.log 2>>$OPENGEMINI_HOME/logs/opengemini.stderr.log &
else
    nohup dlv --listen=:2345 --headless=true --api-version=2 exec $OPENGEMINI_HOME/ts-server -- $CONF_FILE >>$OPENGEMINI_HOME/logs/opengemini.stdout.log 2>>$OPENGEMINI_HOME/logs/opengemini.stderr.log &
fi
