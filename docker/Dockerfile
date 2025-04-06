FROM ubuntu:22.04

ARG GIT_USER
ARG GIT_EMAIL

ENV PATH=/home/user/bin:${PATH}
ENV TZ=Asia/Tokyo
ENV GIT_AUTHOR_NAME=${GIT_USER}
ENV GIT_AUTHOR_EMAIL=${GIT_EMAIL}
ENV GIT_COMMITTER_NAME=${GIT_USER}
ENV GIT_COMMITTER_EMAIL=${GIT_EMAIL}


RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime

COPY <<EOF /etc/sudoers.d/user
user ALL=(ALL) NOPASSWD: ALL

EOF

RUN <<EOF
apt-get update
apt-get install -y gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1

apt-get install -y sudo neovim curl

locale-gen en_US.UTF-8
EOF

RUN useradd -m -s /bin/bash user
WORKDIR /home/user/bin
RUN <<EOF
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > repo
chmod a+x repo
EOF

COPY --chown=user:user <<EOF /home/user/startup.sh
#!/bin/bash

repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-kirkstone -m imx-5.15.71-2.2.0.xml
repo sync

EOF

COPY --chown=user:user <<"EOF" /home/user/setup.sh
#!/bin/bash

BUILD=build
LOCAL_CONF=conf/local.conf
BBLAYERS_CONF=conf/bblayers.conf

if [ -d $BUILD ]; then
	rm $BUILD/$LOCAL_CONF $BUILD/$BBLAYERS_CONF
fi

MACHINE=imx8mn-lpddr4-evk DISTRO=fsl-imx-wayland source ./imx-setup-release.sh -b $BUILD

bitbake-layers add-layer ../sources/meta-customize
bitbake imx-image-core -c populate_sdk

EOF
