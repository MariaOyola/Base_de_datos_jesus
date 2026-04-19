FROM liquibase/liquibase:5.0.2
 
ADD https://jdbc.postgresql.org/download/postgresql-42.7.8.jar \
    /liquibase/liquibase_libs/postgresql-42.7.8.jar
 
USER root
RUN chmod 644 /liquibase/liquibase_libs/postgresql-42.7.8.jar
USER liquibase
 
WORKDIR /workspace
 