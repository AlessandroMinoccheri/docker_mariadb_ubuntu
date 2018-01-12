#!/bin/bash

sed -e 's/mydb/'"$DB_NAME"'/' \
    -e 's/myuser/'"$DB_USER"'/' \
    -e 's/mypassword/'"$DB_PASSWORD"'/' \
    -i /user/local/db.sql

mysql -u root < /user/local/db.sql