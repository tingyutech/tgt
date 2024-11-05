FROM debian:bookworm AS builder
RUN apt-get update -y && \
  apt-get install -y build-essential
COPY . /src
WORKDIR /src
RUN make programs

FROM debian:bookworm
COPY --from=builder /src/usr/tgtd /src/usr/tgtadm /src/usr/tgtimg /usr/sbin/
