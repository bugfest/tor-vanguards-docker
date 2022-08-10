.PHONY: all
all: build

.PHONY: build
build:
	docker buildx build . \
		--platform=linux/amd64,linux/arm,linux/arm64 \
		--build-arg REF=HEAD \
		--tag quay.io/bugfest/vanguards:latest
