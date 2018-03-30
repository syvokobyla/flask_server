ENV = env

PYBIN = $(ENV)/scripts
PYTHON = $(PYBIN)/python
PIP = $(PYBIN)/pip
PYFLAKE8 = $(PYTHON) -m flake8

CODEGEN_RELATIVE_DIR = tmp
CODEGEN_OUTPUT_DIR = $(CURDIR)/$(CODEGEN_RELATIVE_DIR)
SWAGGER_FILE_DIR = $(CURDIR)/docs
SWAGGER_FILE_NAME = swagger.yaml
SWAGGER_FILE_FULL_PATH = $(SWAGGER_FILE_DIR)/$(SWAGGER_FILE_NAME)
SWAGGER_CODEGEN_CONFIG = python_codegen_config.json

.PHONY: help
help:
	@echo "make environ  # initialize environment"
	@echo "make clean    # clean environment"
	@echo "make run      # run app"
	@echo "make flake8   # execute linter"
	
	@echo "make docker_images"
	@echo "make run_codegen"
	@echo "make run_swagger_editor"

.PHONY: environ
environ: clean requirements.txt
	virtualenv $(ENV)
	$(PIP) install -r requirements.txt
	@echo "initialization complete"	
	
.PHONY: docker_images
docker_images:
	docker pull swaggerapi/swagger-editor
	docker pull swaggerapi/swagger-codegen-cli
	@echo "Done"
	
.PHONY: run_swagger_editor
run_swagger_editor:
	docker run --rm --name nbaf-swagger -p 11001:8080 -d swaggerapi/swagger-editor

.PHONY: run_codegen
run_codegen:
	@echo "generating project by using swagger file"
	@docker run --rm -v $(CODEGEN_OUTPUT_DIR):/local -v $(SWAGGER_FILE_DIR):/tmp/docs swaggerapi/swagger-codegen-cli generate -i /tmp/docs/$(SWAGGER_FILE_NAME) -l python-flask -c /tmp/docs/$(SWAGGER_CODEGEN_CONFIG) -o /local/
	@echo "generation finished"

	
.PHONY: clean
clean:
	if exist $(ENV) rd $(ENV) /q /s
	del /S *.pyc
	for /d /r . %%d in (__pycache__) do @if exist "%%d" echo "%%d" && rd /s/q "%%d"
	
.PHONY: run
run:
	@echo TBD run Docker server with APP

.PHONY: run_dev
run_dev:
	python -m upgrade_server

.PHONY: flake8
flake8:
	$(PYFLAKE8) .
