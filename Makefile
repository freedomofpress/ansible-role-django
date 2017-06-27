.DEFAULT_GOAL := ci-go

.PHONY: ci-go
ci-go:
	./devops/scripts/go.sh

.PHONY: tests
tests:
	./devops/scripts/test.sh

.PHONY: teardown
teardown:
	docker kill prod && docker rm -f prod
