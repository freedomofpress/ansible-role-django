.DEFAULT_GOAL := ci-go

.PHONY: ci-go
ci-go:
	./devops/scripts/go.sh

.PHONY: tests
tests:
	./devops/scripts/test.sh

.PHONY: teardown
teardown:
	docker rm -f django_stack_prod
