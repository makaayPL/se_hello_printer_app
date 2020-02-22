.PHONY: test

deps:
	pip install -r requirements.txt \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test  --verbose -s

run-server:
	python main.py

start:
	PYTHONPATH=. workon wsb-simple-flask-app

stop:
	deactivate
