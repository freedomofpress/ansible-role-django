.DEFAULT_GOAL := ci-go

.PHONY: ci-go
ci-go:
	molecule test -s ci && molecule test -s ci_rsync
