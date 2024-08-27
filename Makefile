package:
	pip freeze > requirements.txt
venv:
	source ./venv/bin/activate
build:
	docker build -t template-python .