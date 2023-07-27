FROM node:alpine

#TODO move this values to a .env file
ENV MYSQL_DATABASE test
ENV MYSQL_USER root
ENV MYSQL_PASSWORD super-secret
ENV MYSQL_HOST mysqldb

WORKDIR /usr/src/app

COPY ./ ./

RUN npm install

CMD ["npm", "start"]