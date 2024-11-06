FROM node:21.1.0-slim

ARG BW_TEST_NAME

COPY ./ ./

RUN npm install

ENV NODE_ENV production
ENV BW_TEST_NAME=$BW_TEST_NAME

EXPOSE 8080

CMD ["node", "app.js"]
