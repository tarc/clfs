MKDIR_P = mkdir -p
CHMOD = chmod 777

CLFS = build

.PHONY: buildDir



all: buildDir

buildDir: ${CLFS}

${CLFS}:
	${MKDIR_P} ${CLFS}
	${CHMOD} ${CLFS}
