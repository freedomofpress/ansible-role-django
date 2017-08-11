.DEFAULT_GOAL := ci-go

.PHONY: ci-go
ci-go:
	molecule converge -s ci
