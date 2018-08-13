#!/bin/sh

echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf

# http://pgtune.leopard.in.ua/ (4Go)

# max_connections = 1000
sed -i 's/^max_connections.*/max_connections=1000/' /var/lib/postgresql/data/postgresql.conf
# shared_buffers = 1GB
sed -i 's/^shared_buffers.*/shared_buffers=1GB/' /var/lib/postgresql/data/postgresql.conf
# effective_cache_size = 3GB
sed -i 's/^effective_cache_size.*/effective_cache_size=3GB/' /var/lib/postgresql/data/postgresql.conf
# work_mem = 524kB
sed -i 's/^work_mem.*/work_mem=524kB/' /var/lib/postgresql/data/postgresql.conf
# maintenance_work_mem = 256MB
sed -i 's/^maintenance_work_mem.*/maintenance_work_mem=256MB/' /var/lib/postgresql/data/postgresql.conf
# min_wal_size = 1GB
sed -i 's/^min_wal_size.*/min_wal_size=1GB/' /var/lib/postgresql/data/postgresql.conf
# max_wal_size = 2GB
sed -i 's/^max_wal_size.*/max_wal_size=2GB/' /var/lib/postgresql/data/postgresql.conf
# checkpoint_completion_target = 0.9
sed -i 's/^checkpoint_completion_target.*/checkpoint_completion_target=0.9/' /var/lib/postgresql/data/postgresql.conf
# wal_buffers = 16MB
sed -i 's/^wal_buffers.*/wal_buffers=16MB/' /var/lib/postgresql/data/postgresql.conf
#default_statistics_target = 100
sed -i 's/^default_statistics_target.*/default_statistics_target=100/' /var/lib/postgresql/data/postgresql.conf
