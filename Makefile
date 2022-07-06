build:
	docker build --build-arg=BUILD_PHP_VERSION=8.1 -t nullstone/laravel:local-php8.1 -f local.Dockerfile .
	docker build --build-arg=BUILD_PHP_VERSION=8.1 -t nullstone/laravel:php8.1       -f Dockerfile       .
	docker build --build-arg=BUILD_PHP_VERSION=8.0 -t nullstone/laravel:local-php8.0 -f local.Dockerfile .
	docker build --build-arg=BUILD_PHP_VERSION=8.0 -t nullstone/laravel:php8.0       -f Dockerfile       .
	docker tag nullstone/laravel:php8.1       nullstone/laravel:php8
	docker tag nullstone/laravel:php8.1       nullstone/laravel:latest
	docker tag nullstone/laravel:local-php8.1 nullstone/laravel:local-php8
	docker tag nullstone/laravel:local-php8.1 nullstone/laravel:local

push:
	docker push nullstone/laravel:local-php8
	docker push nullstone/laravel:php8
	docker push nullstone/laravel:local-php8.1
	docker push nullstone/laravel:php8.1
	docker push nullstone/laravel:local-php8.0
	docker push nullstone/laravel:php8.0
	docker push nullstone/laravel:local
	docker push nullstone/laravel:latest
