FROM nginx

COPY /home/oracle/hellowhale/wrapper.sh /

COPY /home/oracle/hellowhale/html /usr/share/nginx/html

CMD ["./wrapper.sh"]
