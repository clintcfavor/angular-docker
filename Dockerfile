FROM node:11.15.0-alpine as build

WORKDIR /usr/src/app

COPY ./ ./

RUN npm install

COPY /dist ./

# EXPOSE 4200

CMD ["npm", "start"]

FROM nginx:1.16.0-alpine as prod

COPY --from=build /usr/src/app/dist/angular-docker /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]