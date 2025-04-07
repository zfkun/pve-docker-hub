FROM alpine:latest AS builder

ARG \
  BUILD_ARCH=amd64 \
  GODNS_REPO=https://github.com/TimothyYe/godns \
  GODNS_VERSION=3.2.3

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai

RUN \
  set -x \
  \
  && if [ "${BUILD_ARCH}" = "armhf" ] || [ "${BUILD_ARCH}" = "armv7" ]; then GODNS_ARCH="arm"; \
    elif [ "${BUILD_ARCH}" = "aarch64" ]; then GODNS_ARCH="arm64"; \
    elif [ "${BUILD_ARCH}" = "i386" ]; then GODNS_ARCH="386"; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then GODNS_ARCH="amd64"; \
    else \
      exit 1; \
    fi \
  \
  && echo "Downloading godns v${GODNS_VERSION} for ${GODNS_ARCH}..." \
  && wget -q -O /tmp/godns.tar.gz "${GODNS_REPO}/releases/download/v${GODNS_VERSION}/godns_${GODNS_VERSION}_linux_${GODNS_ARCH}.tar.gz" \
  && mkdir /tmp/godns-files \
  && tar -xzf /tmp/godns.tar.gz -C /tmp/godns-files \
  && mv -f /tmp/godns-files/godns /usr/bin/godns \
  && rm -rf /tmp/* \
  && chown root:root /usr/bin/godns \
  && chmod a+x /usr/bin/godns

FROM alpine:latest

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai

COPY --from=builder /usr/bin/godns /usr/bin/godns

VOLUME [ "/config" ]

CMD [ "/usr/bin/godns", "-c", "/config/godns.yaml" ]