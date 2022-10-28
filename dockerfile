FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
ARG userid
ARG groupid
ARG username

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade -y && apt-get install -y  git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib \
  g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
  libxml2-utils xsltproc unzip fontconfig jq ccache python3 lld inetutils-ping nano clang libssl-dev rsync wget

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && chmod a+x /usr/local/bin/repo

RUN groupadd -o -g $groupid $username \
 && useradd -m -u $userid -g $groupid $username \
 && echo $username >/root/username \
 && echo "export USER="$username >>/home/$username/.gitconfig

COPY gitconfig /home/$username/.gitconfig
RUN chown $userid:$groupid /home/$username/.gitconfig
ENV HOME=/home/$username
ENV USER=$username

RUN mkdir /home/$username/android
RUN chown $userid:$groupid /home/$username//android

ENTRYPOINT /bin/bash -i
