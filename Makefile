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
	@echo "make environ  				# initialize environment"
	@echo "make clean    				# clean environment"
	@echo "make run      				# run app in docker"
	@echo "make run_dev					# run app on the host
	@echo "make flake8   				# execute linter"
	
	@echo "make pull_swagger"			# pull neccessary swagger docker images 
	@echo "make run_codegen 			# generate swagger-server code from yaml file
	@echo "make run_swagger_editor"		# run swagger editor to edit yaml file
	@echo "make build_docker_image"		# build application docker image
	@echo "make redcw                 # remove exited Docker containers (for Windows)"

.PHONY: environ
environ: clean requirements.txt
	virtualenv $(ENV)
	$(PIP) install -r requirements.txt
	@echo "initialization complete"	
	
.PHONY: pull_swagger
pull_swagger:
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

.PHONY: build_docker_image
build_docker_image: 
	docker build -t upgrade_server
	
.PHONY: clean
clean:
	if exist $(ENV) rd $(ENV) /q /s
	del /S *.pyc
	for /d /r . %%d in (__pycache__) do @if exist "%%d" echo "%%d" && rd /s/q "%%d"
	
.PHONY: run
run:
	docker run --rm -d -p 8080:8080 -v /D/documents/cats:/upgrade/files upgrade_server

.PHONY: run_dev
run_dev:
	$(PYTHON) -m upgrade_server --config 

.PHONY: flake8
flake8:
	$(PYFLAKE8) .

.PHONY: redcw
redcw:
	.\infrastructure\tools\win\redcw.bat