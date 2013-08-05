MKDIR_P = mkdir -p
CHMOD777 = chmod 777
CHMODAWT = chmod -v a+wt

CLFS = build
SRC = build/src

.PHONY: buildDir



all: buildDir

buildDir: ${CLFS} ${SRC}

${CLFS}:
	${MKDIR_P} ${CLFS}
	${CHMOD777} ${CLFS}

${SRC}:
	${MKDIR_P} ${SRC}
	${CHMODAWT} ${SRC}
