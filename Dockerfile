# Dockerfile for lighttpd

FROM alpine

RUN apk add --update --no-cache \
	lighttpd \
	lighttpd-mod_auth \
  && rm -rf /var/cache/apk/*

## workaround for bug preventing sync between VirtualBox and host
# http://serverfault.com/questions/240038/lighttpd-broken-when-serving-from-virtualbox-shared-folder
RUN echo server.network-backend = \"writev\" >> /etc/lighttpd/lighttpd.conf

COPY etc/lighttpd/* /etc/lighttpd/
COPY start.sh /usr/local/bin/

EXPOSE 80

ENV DOCUMENT_ROOT /var/www/localhost/htdocs
ENV DOCUMENT_CGI_ROOT /var/www/localhost/cgi-bin/
VOLUME /var/www/localhost
VOLUME /etc/lighttpd

CMD ["start.sh"]
