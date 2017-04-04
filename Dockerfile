FROM hotio/debian-base
MAINTAINER hotio

# set build arg
ARG DEBIAN_FRONTEND=noninteractive

# install
RUN apt-get update && \
    apt-get install -y \
        libcurl3 \
        libsqlite3-0 \
        libmono-cil-dev \
        mediainfo && \

    jobid=$(curl -s "https://ci.appveyor.com/api/projects/galli-leo/radarr-usby1/branch/develop" | jq -r '.build.jobs[0].jobId') && \
    filename=$(curl -s "https://ci.appveyor.com/api/buildjobs/${jobid}/artifacts" | jq -r '.[0].fileName') && \
    curl -s -o /tmp/radarr.tar.gz -L "https://ci.appveyor.com/api/buildjobs/${jobid}/artifacts/${filename}" && \
    tar ixzf /tmp/radarr.tar.gz -C /app --strip-components=1 && \

# clean up
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 7878
VOLUME ["/config"]
