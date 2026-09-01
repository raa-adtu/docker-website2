FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
COPY about.html /usr/share/nginx/html/about.html
COPY courses.html /usr/share/nginx/html/courses.html
COPY contact.html /usr/share/nginx/html/contact.html

EXPOSE 80
