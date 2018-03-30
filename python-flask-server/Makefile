ENV = env

PYBIN = $(ENV)/scripts
PYTHON = $(PYBIN)/python
PIP = $(PYBIN)/pip
PYTEST = $(PYTHON) -m pytest
PYFLAKE8 = $(PYTHON) -m flake8

.PHONY: help
help:
	@echo "make environ  # initialize environment"
	@echo "make clean    # clean environment"
	@echo "make run      # run app"
	@echo "make flake8   # execute linter"

.PHONY: environ
environ: clean requirements.txt
	virtualenv $(ENV)
	$(PIP) install -r requirements.txt
	@echo "initialization complete"	
	
.PHONY: clean
clean:
	if exist $(ENV) rd $(ENV) /q /s
	if exist .coverage del .coverage
	if exist .tox rd .tox /q /s
	if exist htmlcov rd htmlcov /q /s
	del /S *.pyc
	for /d /r . %%d in (__pycache__) do @if exist "%%d" echo "%%d" && rd /s/q "%%d"
	
.PHONY: run
run:
	python -m swagger_server

.PHONY: flake8
flake8:
	$(PYFLAKE8) .
