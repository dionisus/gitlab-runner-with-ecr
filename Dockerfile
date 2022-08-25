FROM ubuntu:20.04 AS build
ENV DEBIAN_FRONTEND=noninteractive
RUN : \
 && apt-get update \
 && apt-get install --no-install-recommends -y git ca-certificates amazon-ecr-credential-helper \
 && rm -rf /var/lib/apt/lists/* \
;
WORKDIR /build
RUN mv /usr/bin/docker-credential-ecr-login .

FROM gitlab/gitlab-runner:v15.3.0 AS deploy
COPY --from=build /build/docker-credential-ecr-login /usr/bin/docker-credential-ecr-login

