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
set -ex
IMAGEVERISON=$(<codepipeline/version.txt)
echo $IMAGEVERISON

sh codepipeline/version.sh
echo $IMAGEVERISON

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com

docker build $AppPath/ -t demo-java
docker tag demo-java:latest $ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com/demo-java:${IMAGEVERISON}
docker push $ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com/demo-java:${IMAGEVERISON}

sam deploy --config-file $LAMBDAPATH/samconfig.toml \
--template-file $LAMBDAPATH/template.yml \
--stack-name lambda-config \
--image-repository $ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com/${ECRNAME} \
--capabilities CAPABILITY_NAMED_IAM \
--no-confirm-changeset \
--no-fail-on-empty-changeset \
--parameter-overrides Version=$IMAGEVERISON

if [ $? == 0 ]
then
	echo "Sam Function has been deployed successfully."
else
	 echo "Sam Function failed to deploy."
fi
