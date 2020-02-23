.PHONY: test

SERVICE_NAME=hello-world-printer
USERNAME=marcintester
TAG=$(USERNAME)/$(SERVICE_NAME)

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test  --verbose -s

test_smoke:
	curl -s -o /dev/null -w "%{http_code}" --fail 127.0.0.1:5000

run-server:
	python main.py

start:
	source /usr/local/bin/virtualenvwrapper.sh && PYTHONPATH=. workon wsb-simple-flask-app

stop:
	deactivate

docker_build:
	docker build -t $(SERVICE_NAME) .

docker_run: docker_build
	docker run \
	--name $(SERVICE_NAME)-dev \
	-p 5000:5000 \
	-d $(SERVICE_NAME)

docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag $(SERVICE_NAME) $(TAG); \
	docker push $(TAG); \
	docker logout;
