# Optional Dockerfile to package the Lambda as a container image.
# This is not wired into Terraform by default, but shows how you could
# build and push an image to ECR for a container-based Lambda or ECS.

FROM public.ecr.aws/lambda/python:3.14.0

# Copy function code
COPY app ${LAMBDA_TASK_ROOT}/app
COPY requirements.txt ${LAMBDA_TASK_ROOT}/requirements.txt

RUN pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Lambda handler
CMD ["app.handler.lambda_handler"]
