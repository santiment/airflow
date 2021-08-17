build:
	./breeze build-image --production-image\
		--python 3.8\
		--backend postgres\
		--installation-method .\
		--github-repository santiment/airflow

push:
	./breeze push-image -v --production-image\
		--use-github-registry\
		--github-repository santiment/airflow\
