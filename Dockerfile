FROM alpine
WORKDIR /usr/workdir
ENV NJSSCAN_VERSION=0.2.9


RUN apk update \
&& apk upgrade \
&& apk add --no-cache bash \
&& apk add --no-cache --virtual=build-dependencies unzip \
&& apk add --no-cache curl \
&& apk add --no-cache nss \
&& apk add --no-cache openjdk8-jre \
&& apk add --no-cache python3-dev \
&& apk add --no-cache gcc \
&& apk add --no-cache libc-dev \
&& apk add --no-cache libffi-dev

RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

RUN apk add --no-cache python3 \
&& python3 -m ensurepip \
&& pip3 install --upgrade pip setuptools \
&& rm -r /usr/lib/python*/ensurepip && \
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
rm -r /root/.cache

RUN pip install --trusted-host pypi.python.org flask

RUN pip3 install checkov==2.0.283

RUN pip install njsscan==$NJSSCAN_VERSION

RUN pip install bandit

RUN apk add --update --no-cache vim git make musl-dev go curl
# Configure Go
RUN export GOPATH=/root/go
RUN export PATH=${GOPATH}/bin:/usr/local/go/bin:$PATH
RUN export GOBIN=$GOROOT/bin
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
RUN export GO111MODULE=on
RUN go version

RUN mkdir /usr/share/sl
RUN mkdir /usr/share/sl/data


ADD target/ecom-1.0.jar /usr/share/sl/ecom-1.0.jar 

WORKDIR /workdir

ENTRYPOINT ["java","-jar","ecom-1.0.jar"]
CMD ["-h"]
