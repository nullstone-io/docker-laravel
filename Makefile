build:
	docker build -t nullstone/laravel:local -f local.Dockerfile .
	docker build -t nullstone/laravel .

push:
	docker push nullstone/laravel:local
	docker push nullstone/laravel
