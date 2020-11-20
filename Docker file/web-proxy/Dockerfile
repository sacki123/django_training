FROM nginx:alpine
COPY dhparam.pem /etc/nginx/dhparam.pem
COPY params /etc/nginx/params
COPY ssl /etc/nginx/ssl
COPY nginx.conf /etc/nginx/nginx.conf
COPY .htpasswd /etc/nginx/.htpasswd
COPY ./src/www /opt/services/djangoapp/src/www