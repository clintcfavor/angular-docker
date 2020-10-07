FROM node:11.15.0-alpine as build

# WORKDIR /usr/src/app
WORKDIR /app

COPY ./ ./

RUN npm install

# EXPOSE 4200

CMD ["npm", "start"]

FROM nginx:1.16.0-alpine as prod

# COPY --from=build /usr/src/app/dist/angular-docker /usr/share/nginx/html
COPY --from=build /app/dist/angular-docker /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]