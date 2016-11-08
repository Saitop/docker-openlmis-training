#!/usr/bin/env bash

unzip /usr/local/tomcat/webapps/db/db.jar -d /opt/flyway/sql/db
unzip /usr/local/tomcat/webapps/db/migration.jar -d /opt/flyway/sql/migration

/opt/flyway/flyway \
  -url=jdbc:postgresql://$POSTGRES_HOST:5432/open_lmis \
  -schemas=public,atomfeed \
  -user=$POSTGRES_USER_NAME \
  -password=$POSTGRES_PASSWORD \
  -table=schema_version \
  -placeholderReplacement=false \
  -locations=filesystem:/opt/flyway/sql/db \
  migrate

/opt/flyway/flyway \
  -url=jdbc:postgresql://$POSTGRES_HOST:5432/open_lmis \
  -schemas=public,atomfeed \
  -user=$POSTGRES_USER_NAME \
  -password=$POSTGRES_PASSWORD \
  -table=migration_schema_version \
  -placeholderReplacement=false \
  -baselineOnMigrate=true \
  -locations=filesystem:/opt/flyway/sql/migration \
  migrate
