FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY tsconfig.json ./
COPY src ./src
RUN npm run build


FROM build as dev
RUN npm i -g ts-node
CMD [ "npm", "run", "dev" ]


FROM node:lts-slim AS prod
ENV NODE_ENV production
ENV PORT 3000
#USER node
COPY package*.json ./
RUN npm ci --omit=dev
COPY --from=build /app/dist ./dist
EXPOSE ${PORT}
CMD [ "npm", "run", "start" ]
 