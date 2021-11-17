# Modernizing deployments with container images in AWS Lambda
This post demonstrates how to use AWS continuous integration and deployment (CI/CD) services and Docker to separate the container build process from the application deployment process.

## Motivation
This solution shows how to build, manage, and deploy Lambda container images automatically with infrastructure as code (IaC). It also covers automatically updating or creating Lambda functions based on a container image version. The application uses Docker to build the container image and an ECR repository to store the container image. AWS SAM deploys the Lambda function based on the new container.

## How to use?
To deploy this project follow the step by step instructions found here: https://aws.amazon.com/blogs/compute/modernizing-deployments-with-container-images-in-aws-lambda/

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
