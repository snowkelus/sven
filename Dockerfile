FROM alpine:3.9

LABEL "com.github.actions.name"="Push new files back to supplied branch name.."
LABEL "com.github.actions.description"="A GitHub Action to push any new files back to supplied branch name.."
LABEL "com.github.actions.icon"="arrow-up"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/snowkelus/sven"
LABEL "homepage"="https://github.com/snowkelus/sven"
LABEL "maintainer"="snowkelus"

RUN apk --no-cache add openssl git curl openssh-client bash
    
COPY sven.sh /sven.sh
ENTRYPOINT [ "/sven.sh" ]

RUN echo CWD `pwd` \
    && mkdir /tmp/lfs \
    && cd /tmp/lfs \
    && curl -sLO https://github.com/git-lfs/git-lfs/releases/download/v2.6.0/git-lfs-linux-amd64-v2.6.0.tar.gz \
    && tar -zxf git-lfs-linux-amd64-v2.6.0.tar.gz \
    && ./install.sh \
    && cd / \
    && rm -rf /tmp/lfs