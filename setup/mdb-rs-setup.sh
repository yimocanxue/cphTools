#!/bin/bash

source /etc/profile

service ssh start

mongo --host $MDB_PRIMARY_HOST --port $MDB_PRIMARY_PORT <<EOF

   var cfg = {
        "_id": "$MDB_RS_NAME",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "$MDB_PRIMARY_HOST:$MDB_PRIMARY_PORT",
                "priority": 5
            },
            {
                "_id": 1,
                "host": "$MDB_SEC_1_HOST:$MDB_SEC_1_PORT",
                "priority": 4
            },
            {
                "_id": 2,
                "host": "$MDB_SEC_2_HOST:$MDB_SEC_2_PORT",
                "priority": 3
            },
            {
                "_id": 6,
                "host": "$MDB_ARBITER_HOST:$MDB_ARBITER_PORT",
                "priority": 1,
                "arbiterOnly" : true
            }
        ]
    };
    try{
        var config = rs.config();
        rs.reconfig(cfg, { force: true });
    }catch(err){
        rs.initiate(cfg);
    }
EOF


tail -f /dev/null

