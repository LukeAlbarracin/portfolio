help:
	@echo make env
	@echo make install
	@echo make run
	@echo make build
	@echo make deploy

env:
	pipenv shell

install:
	pipenv install

run:
	mkdocs serve

build:
	mkdocs build

deploy:
	mkdocs gh-deploy
