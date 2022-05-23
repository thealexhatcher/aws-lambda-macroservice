SHELL := /bin/bash

.PHONY: default package test clean

POETRY_DIST_DIR := $(PWD)/dist
BUILD_DIR := $(PWD)/build
DEPLOY_DIR := $(PWD)
ARTIFACT := package.zip

default: package

package:
	poetry build
	mkdir -p $(BUILD_DIR)
	poetry run pip install --upgrade -t $(BUILD_DIR) $(POETRY_DIST_DIR)/*.whl
	cd $(BUILD_DIR) ; zip -r $(DEPLOY_DIR)/$(ARTIFACT) . -x '*.pyc'

init:
	poetry install

test:	
	poetry run python -m pytest

run: 
	uvicorn api.api:api --reload --port 5000

clean:
	find . | grep -E __pycache__ | xargs rm -rf
	rm -rf .pytest_cache
	rm -rf $(POETRY_DIST_DIR)
	rm -rf $(BUILD_DIR)
	rm -f $(DEPLOY_DIR)/$(ARTIFACT)	

nuke: clean
	rm -rf .eggs
	rm -rf .venv
	
