SHELL := /bin/bash
STACKNAME?= "aws-lambda-macroservice"
S3_BUCKET?= "838211705424-us-east-1-cloudformation" #OVERRIDE THIS BUCKET NAME
S3_PREFIX?= "local"

.PHONY: init validate build package deploy destroy postman-local postman-test test run clean nuke

init:
	poetry install

validate:
	aws cloudformation validate-template --template-body file://infra/cfn_api.yml --output text

build:
	poetry build
	mkdir -p build/lambda
	poetry run pip install --upgrade -t $(PWD)/build/lambda $(PWD)/dist/*.whl
	cd build/lambda ; zip -r $(PWD)/build/lambda.zip . -x '*.pyc'

	mkdir -p build/layer/python
	poetry run pip install --upgrade -t $(PWD)/build/layer/python -r $(PWD)/layer/requirements.txt
	cd build/layer && zip -r $(PWD)/build/layer.zip . -x '*.pyc'

package: validate
	aws cloudformation package --template-file infra/cfn_api.yml --s3-bucket $(S3_BUCKET) --s3-prefix $(S3_PREFIX) --output-template-file build/cfn_api.out.yml

deploy: package
	aws cloudformation deploy --template-file build/cfn_api.out.yml --stack-name $(STACKNAME) --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND 

destroy:
	aws cloudformation delete-stack --stack-name $(STACKNAME) && aws cloudformation wait stack-delete-complete --stack-name $(STACKNAME)

postman-local:	
	newman run postman/api.tests.json -e postman/local.env.json -r cli --insecure --ignore-redirects	

postman-test:
	newman run postman/api.tests.json -e postman/test.env.json -r cli --insecure --ignore-redirects	

test:	
	poetry run python -m pytest

run: 
	uvicorn macroservice.api:api --reload --port 5000

clean:
	find . | grep -E __pycache__ | xargs rm -rf
	rm -rf .pytest_cache
	rm -rf dist
	rm -rf build

nuke: clean
	rm -rf .eggs
	rm -rf .venv
	
