FROM debian:bookworm AS builder
RUN apt-get update -y && \
  apt-get install -y build-essential librados-dev librbd-dev
COPY . /src
WORKDIR /src
RUN make programs CEPH_RBD=1

FROM debian:bookworm
RUN apt-get update -y && \
  apt-get install -y ceph-common glusterfs-common && \
  rm -rf /var/lib/apt/lists/*
COPY --from=builder /src/usr/tgtd /src/usr/tgtadm /src/usr/tgtimg /usr/sbin/
COPY --from=builder /src/usr/bs_rbd.so /usr/lib/tgt/backing-store/
