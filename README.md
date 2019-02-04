# git
Dockerized git server (based on Alpine)

Run container: `docker run -d ursus/git`



## Tags

* `ursus/git[:latest]`

* `ursus/git:python`

  Enables use of python3 scripts in git hooks and git shell commands



## `git` user

* Home directory: `/srv/git` (owned by `git` user)
* Shell: `/usr/bin/git-shell`
* To enable ssh login, add public keys to `/srv/git/.ssh/authorized_keys`
  * Using docker

    `docker exec -it CONTAINER sh -c "echo $(cat ~/.ssh/{KEY_NAME}.pub) >> /srv/git/.ssh/authorized_keys"`
  * In a Dockerfile

    `COPY {KEY_NAME}.pub /srv/git/.ssh/authorized_keys`
    `RUN chmod 600 /srv/git/.ssh/authorized_keys`
    `RUN chown git:git /srv/git/.ssh/authorized_keys`
* To add a repository

  * `docker exec -it CONTAINER sh -c "su git -s /bin/sh -c 'git init --bare REPOSITORY_NAME.git'"`
* To clone a repository
  * `git clone git@ADDRESS:REPOSITORY_NAME.git`
  * `git clone ssh://git@ADDRESS:PORT/~/REPOSITORY_NAME.git`
* To access /bin/sh as git user

  * `docker exec -it CONTAINER sh -c "su git -s /bin/sh"`

### Note:

* To disable the git-shell prompt or display a message when accessing through ssh
  * Add a script named `no-interactive-login` to `/srv/git/git-shell-commands` and make sure to `chmod +x /srv/git/git-shell-commands/no-interactive-login`