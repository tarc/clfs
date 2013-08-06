MKDIR_P = mkdir -p
CHMOD777 = chmod 777
CHMODAWT = chmod -v a+wt
WGET = wget -c

CLFS = build
SRC = build/src

BINUTILS = binutils-2.23.2.tar.bz2
BUSYBOX = busybox-1.21.0.tar.bz2
GCC = gcc-4.7.3.tar.bz2
GMP = gmp-5.1.2.tar.bz2
IANA = iana-etc-2.30.tar.bz2
LINUX = linux-3.0.80.tar.bz2
MPC = mpc-1.0.1.tar.gz
MPFR = mpfr-3.1.2.tar.bz2
UCLIBC = uClibc-0.9.31.tar.bz2

BUSYBOXPATCH = busybox-1.21.0-config-1.patch
IANAPATCH = iana-etc-2.30-update-1.patch
IANAPATCH = uClibc-0.9.31-configs-2.patch

.PHONY: buildDir download patches environment


all: buildDir download

buildDir: ${CLFS} ${SRC}

${CLFS}:
	${MKDIR_P} ${CLFS}
	${CHMOD777} ${CLFS}

${SRC}:
	${MKDIR_P} ${SRC}
	${CHMODAWT} ${SRC}



download: ${SRC}/${BINUTILS} ${SRC}/${BUSYBOX} ${SRC}/${GCC} ${SRC}/${GMP} ${SRC}/${IANA} ${SRC}/${LINUX} ${SRC}/${MCP} ${SRC}/${MPFR} ${SRC}/${UCLIBC} patches

${SRC}/${BINUTILS}:
	${WGET} -O ${SRC}/${BINUTILS} http://ftp.gnu.org/gnu/binutils/${BINUTILS}

${SRC}/${BUSYBOX}:
	${WGET} -O ${SRC}/${BUSYBOX} http://busybox.net/downloads/${BUSYBOX}

${SRC}/${GCC}:
	${WGET} -O ${SRC}/${GCC} http://gcc-uk.internet.bs/releases/gcc-4.7.3/${GCC}

${SRC}/${GMP}:
	${WGET} -O ${SRC}/${GMP} http://ftp.gnu.org/gnu/gmp/${GMP}

${SRC}/${IANA}:
	${WGET} -O ${SRC}/${IANA} http://sethwklein.net/${IANA}

${SRC}/${LINUX}:
	${WGET} -O ${SRC}/${LINUX} http://www.kernel.org/pub/linux/kernel/v3.x/${LINUX}

${SRC}/${MPC}:
	${WGET} -O ${SRC}/${MPC} http://www.multiprecision.org/mpc/download/${MCP}

${SRC}/${MPFR}:
	${WGET} -O ${SRC}/${MPFR} http://gforge.inria.fr/frs/download.php/32210/${MPFR}

${SRC}/${UCLIBC}:
	${WGET} -O ${SRC}/${UCLIBC} http://www.uclibc.org/downloads/${UCLIBC}


patches: ${SRC}/${BUSYBOXPATCH} ${SRC}/${IANAPATCH} ${SRC}/${UCLIBCPATCH}

${SRC}/${BUSYBOXPATCH}:
	${WGET} -O ${SRC}/${BUSYBOXPATCH} http://patches.cross-lfs.org/embedded-dev/

${SRC}/${IANAPATCH}:
	${WGET} -O ${SRC}/${IANAPATCH}  http://patches.cross-lfs.org/embedded-dev/${IANAPATCH}

${SRC}/${UCLIBCPATCH}:
	${WGET} -O ${SRC}/${UCLIBCPATCH} http://patches.cross-lfs.org/embedded-dev/${UCLIBCPATCH}


environment: ${CLFS}/.bashrc
	exec env -i HOME=$(shell pwd)/${CLFS} TERM=${TERM} /bin/bash

${CLFS}/.bashrc:
	echo "set +h;\
	umask 022;\
	CLFS=$(shell pwd)/${CLFS};\
	LC_ALL=POSIX;\
	PATH=$(shell pwd)/${CLFS}/cross-tools/bin:/bin:/usr/bin;\
	export CLFS LC_ALL PATH;\
	PS1='\u:\w\$$ '" > ${CLFS}/.bashrc

