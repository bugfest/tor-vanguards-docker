FROM alpine/git as source
ARG REF=HEAD
ARG SRCDIR=/src

RUN git clone --no-checkout https://github.com/mikeperry-tor/vanguards ${SRCDIR}
RUN git -C ${SRCDIR} checkout ${REF}
RUN git -C ${SRCDIR} describe --tags > /version
WORKDIR ${SRCDIR}

FROM pypy:3-slim as builder
ARG SRCDIR=/src

COPY --from=source ${SRCDIR} ${SRCDIR}
WORKDIR ${SRCDIR}
RUN pypy -m pip install .

FROM pypy:3-slim as runner

COPY --from=builder /opt/pypy /opt/pypy
COPY --from=source /version /version

ENTRYPOINT ["/opt/pypy/bin/vanguards"]
