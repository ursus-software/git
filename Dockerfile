FROM alpine
LABEL maintainer = "Djordje Stojanovic <djordje.stojanovic@ursus.rs>"

RUN echo > /etc/motd
RUN apk --no-cache add git openssh
COPY entrypoint.sh /
RUN echo "/usr/bin/git-shell" >> /etc/shells
RUN adduser -h /srv/git -s /usr/bin/git-shell -D -k /dev/null git
RUN sed -i 's/git:!/git:*/' /etc/shadow
WORKDIR /srv/git
RUN mkdir .ssh && chmod 700 .ssh
RUN touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
RUN mkdir git-shell-commands
RUN chown -R git:git .

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]