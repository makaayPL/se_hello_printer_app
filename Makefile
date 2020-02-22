.PHONY: test

deps:
	sudo pip install virtualenv \
	sudo pip install virtualenvwrapper \
	source /usr/local/bin/virtualenvwrapper.sh \
	mkvirtualenv wsb-simple-flask-app \
	pip install -r requirements.txt \
	pip install -r test_requirements.txt \
	source /usr/local/bin/virtualenvwrapper.sh

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
