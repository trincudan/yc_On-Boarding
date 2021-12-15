## Docker

> I will keep just *Dockerfile* and *README.md* in this repo, I don't think anybody wants to see any docker files here.

For this, i've used [docs.docker - Getting Started]https://docs.docker.com/get-started/02_our_app/ tutorial.

1. I've downloaded [App]https://github.com/docker/getting-started/tree/master/app contents and created *Dockerfile* with the following content:

'''
# syntax=docker/dockerfile:1
FROM node:12-alpine
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
'''

2. I've built the container image using `docker build -t getting-started`.

3. I've started the container using `docker run -dp 3000:3000 getting-started`.

<p align="center">
<img src="https://ibb.co/t3mqS5j">
</p>
