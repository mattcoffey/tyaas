FROM node:4-onbuild

COPY . /opt/tyaas

WORKDIR /opt/tyaas

RUN npm install

EXPOSE 5000

CMD ["/usr/local/bin/npm", "start"]
