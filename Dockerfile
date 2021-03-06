FROM jcorioland/azure-terratest:0.12.8

ARG BUILD_MODULE_NAME="aks-module"
ENV MODULE_NAME=${BUILD_MODULE_NAME}

RUN ssh-keygen -b 2048 -t rsa -f ~/.ssh/testing_rsa -q -N ""

# Set work directory.
RUN mkdir /go/src/${MODULE_NAME}
COPY . /go/src/${MODULE_NAME}
WORKDIR /go/src/${MODULE_NAME}

RUN chmod +x run-tests.sh

ENTRYPOINT [ "./run-tests.sh" ]