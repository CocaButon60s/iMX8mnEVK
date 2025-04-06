SRC_URI = "\
	git://github.com/moby/moby;branch=20.10;name=docker;protocol=https \
	git://github.com/moby/libnetwork;branch=master;name=libnetwork;destsuffix=git/libnetwork;protocol=https \
	git://github.com/docker/cli;branch=20.10;name=cli;destsuffix=git/cli;protocol=https \
	file://0001-libnetwork-use-GO-instead-of-go.patch \
	file://docker.init \
	file://0001-dynbinary-use-go-cross-compiler.patch \
	file://0001-cli-use-external-GO111MODULE-and-cross-compiler.patch \
	"
	