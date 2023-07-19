build:
	docker buildx bake -f docker-bake.8-1.hcl
	docker buildx bake -f docker-bake.8-0.hcl

push:
	docker buildx bake --push -f docker-bake.8-1.hcl
	docker buildx bake --push -f docker-bake.8-0.hcl
