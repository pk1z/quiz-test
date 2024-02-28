FROM nginx

WORKDIR /var/www/html

COPY . ./

COPY ./images/nginx/nginx.conf /etc/nginx/conf.d/default.conf

#EXPOSE 8000
CMD ["nginx", "-g", "daemon off;"]
