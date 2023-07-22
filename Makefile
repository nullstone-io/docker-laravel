build:
	docker buildx bake -f docker-bake.hcl

push:
	docker buildx bake --push -f docker-bake.hcl
