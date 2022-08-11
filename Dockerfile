#------ Source

FROM alpine/git as source
ARG REF=HEAD
ARG SRCDIR=/src

RUN git clone --no-checkout https://github.com/mikeperry-tor/vanguards ${SRCDIR}
RUN git -C ${SRCDIR} checkout ${REF}
RUN git -C ${SRCDIR} describe --tags > /version
WORKDIR ${SRCDIR}

#------ Builder

FROM debian:buster-slim as py3
ARG PYPYVER=pypy3.9-v7.3.9

RUN apt-get update
RUN apt-get install -y wget bzip2

COPY install-pypy.sh /.
RUN bash -x /install-pypy.sh || apt-get install -y python3 python3-pip
ENV PATH /opt/pypy/bin:$PATH

#------ Installer

FROM py3 as installer
ARG SRCDIR=/src

COPY --from=source ${SRCDIR} ${SRCDIR}
WORKDIR ${SRCDIR}
RUN python -m pip install .

#------ Runner

FROM python as runner
COPY --from=installer /opt/pypy /opt/pypy
COPY --from=source /version /version

ENTRYPOINT ["/opt/pypy/bin/vanguards"]
