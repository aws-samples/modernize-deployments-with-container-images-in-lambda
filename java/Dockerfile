# Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

ARG WORK_DIR="/app"

FROM public.ecr.aws/amazoncorretto/amazoncorretto:latest AS builder
ARG WORK_DIR
ARG FUNCTION_DIR

RUN yum install -y \
	maven

WORKDIR ${WORK_DIR}
COPY . ${WORK_DIR}

WORKDIR ${WORK_DIR}/
RUN mvn dependency:go-offline dependency:copy-dependencies && \
	mvn package

FROM public.ecr.aws/lambda/java@sha256:f50229f502d073d6ba56ca6320d98f6d91b3dba4ded8a7706c100222954a8458
ARG WORK_DIR

COPY --from=builder ${WORK_DIR}/target/dependency /var/task/lib
COPY --from=builder ${WORK_DIR}/target/classes /var/task/

CMD [ "com.example.aws.containerdemo.App::handleRequest" ]

