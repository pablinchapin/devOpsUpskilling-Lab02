FROM mysql:latest

#TODO move this values to a .env file
ENV MYSQL_ROOT_PASSWORD super-secret
ENV MYSQL_DATABASE test

EXPOSE 3306

COPY ./testdump.sql /docker-entrypoint-initdb.d/
