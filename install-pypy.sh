#!/bin/bash

ARCH=$(uname -m)
PYPYVER=pypy3.9-v7.3.9
SKIP_PYPY=0

case $ARCH in
    i386)
        PYPY_RELEASE=${PYPYVER}-linux32
        ;;
    x86_64)
        PYPY_RELEASE=${PYPYVER}-linux64
        ;;
    arm64)
        PYPY_RELEASE=${PYPYVER}-aarch64
        ;;
    390x)
        PYPY_RELEASE=${PYPYVER}-s390x
        ;;
    *)
        # This arch will use python as fallback
        SKIP_PYPY=1
        ;;
esac

if [ $SKIP_PYPY -eq 1 ]; then
    echo "This arch ($ARCH) does not currently have pre-compiled pypy binaries available"
    exit 1
fi

wget https://downloads.python.org/pypy/${PYPY_RELEASE}.tar.bz2 -O /tmp/${PYPY_RELEASE}.tar.bz2
pushd /opt
tar jxvf /tmp/${PYPY_RELEASE}.tar.bz2
ln -s ${PYPY_RELEASE} pypy
/opt/pypy/bin/pypy -m ensurepip

echo "pypy installed at /opt/pypy/bin/pypy"
exit 0