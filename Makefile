build:
	./breeze build-image --production-image \
		--python 3.8 \
		--backend postgres \
		--installation-method . \
		--github-repository santiment/airflow \
		--use-github-registry \
		--force-build-images \
		--cleanup-docker-context-files

build-dryrun:
	./breeze build-image --production-image \
		--python 3.8 \
		--backend postgres \
		--installation-method . \
		--github-repository santiment/airflow \
		--use-github-registry \
		--force-build-images \
		--cleanup-docker-context-files \
		--dry-run-docker


push:
	./breeze push-image -v --production-image \
		--use-github-registry \
		--github-repository santiment/airflow
