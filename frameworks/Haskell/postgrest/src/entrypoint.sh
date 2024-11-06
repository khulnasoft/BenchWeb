#!/bin/bash
touch /root/.pgpass
chmod 600 /root/.pgpass
echo bw-database:5432:hello_world:benchmarkdbuser:benchmarkdbpass >> /root/.pgpass 
cat *.sql | psql -U benchmarkdbuser -h bw-database -d hello_world
/usr/local/bin/postgrest /etc/postgrest.conf > /dev/null 2>&1